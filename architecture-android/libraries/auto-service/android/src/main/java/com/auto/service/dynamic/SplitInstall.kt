@file:Suppress("unused")

package com.auto.service.dynamic

import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.IntentSender.SendIntentException
import android.os.Bundle
import android.util.Log
import androidx.annotation.RestrictTo
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.google.android.play.core.common.IntentSenderForResultStarter
import com.google.android.play.core.splitcompat.SplitCompat
import com.google.android.play.core.splitinstall.*
import com.google.android.play.core.splitinstall.model.SplitInstallErrorCode
import com.google.android.play.core.splitinstall.model.SplitInstallSessionStatus
import kotlin.coroutines.Continuation
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine

class SplitInstall(
    private val context: Context,
    private val splitInstallManager: SplitInstallManager = createSplitInstallManager(context),
) {
    companion object {
        const val REQUEST_CODE_REQUIRES_USER_CONFIRMATION = 0
        internal val onRequiresUserConfirmation =
            MutableLiveData<Pair<SplitInstallManager, SplitInstallSessionState>?>()

        fun registerRequiresUserConfirmation(
            splitInstallManager: SplitInstallManager,
            splitInstallSessionState: SplitInstallSessionState,
        ) {
            onRequiresUserConfirmation.postValue(
                Pair(
                    splitInstallManager,
                    splitInstallSessionState
                )
            )
        }

        fun install(application: Application) {
            SplitCompat.install(application)
            SplitActivityAutoConfiguration.install(application)
        }

        /**
         * Create a new [SplitInstallManager].
         */
        internal fun createSplitInstallManager(context: Context): SplitInstallManager =
            SplitInstallManagerFactory.create(context)

        internal fun terminateLiveData(status: MutableLiveData<SplitInstallSessionState>) {
            // Best effort leak prevention, will only work for active observers
            check(!status.hasActiveObservers()) {
                "This DynamicInstallMonitor will not " +
                        "emit any more status updates. You should remove all " +
                        "Observers after null has been emitted."
            }
        }
    }

    /**
     * @param module The module to install.
     * @return Whether the requested module needs installation.
     * @hide
     */
    @RestrictTo(RestrictTo.Scope.LIBRARY_GROUP)
    fun needsInstall(module: String): Boolean {
        return !splitInstallManager.installedModules.contains(module)
    }

    @Throws(SendIntentException::class)
    fun startConfirmationDialogForResult(
        sessionState: SplitInstallSessionState,
        activity: Activity,
        requestCode: Int,
    ): Boolean =
        !splitInstallManager.startConfirmationDialogForResult(sessionState, activity, requestCode)

    @Throws(SendIntentException::class)
    fun startConfirmationDialogForResult(
        sessionState: SplitInstallSessionState,
        starter: IntentSenderForResultStarter,
        requestCode: Int,
    ): Boolean =
        !splitInstallManager.startConfirmationDialogForResult(sessionState, starter, requestCode)

    private fun requestInstall(
        module: String,
        installMonitor: SplitInstallMonitor,
    ) {
        check(!installMonitor.isUsed) {
            // We don't want an installMonitor in an undefined state or used by another install
            "You must pass in a fresh SplitInstallMonitor every time you call get()."
        }

        val status = installMonitor.status as MutableLiveData<SplitInstallSessionState>
        installMonitor.isInstallRequired = true

        val request = SplitInstallRequest
            .newBuilder()
            .addModule(module)
            .build()

        splitInstallManager
            .startInstall(request)
            .addOnSuccessListener { sessionId ->
                installMonitor.sessionId = sessionId
                installMonitor.splitInstallManager = splitInstallManager
                if (sessionId == 0) {
                    // The feature is already installed, emit synthetic INSTALLED state.
                    status.value = SplitInstallSessionState.create(
                        sessionId,
                        SplitInstallSessionStatus.INSTALLED,
                        SplitInstallErrorCode.NO_ERROR,
                        /* bytesDownloaded */ 0,
                        /* totalBytesToDownload */ 0,
                        listOf(module),
                        emptyList()
                    )
                    terminateLiveData(status)
                } else {
                    val listener = object : SplitInstallStateUpdatedListener {
                        override fun onStateUpdate(
                            splitInstallSessionState: SplitInstallSessionState,
                        ) {
                            if (splitInstallSessionState.sessionId() == installMonitor.sessionId) {
                                if (splitInstallSessionState.status() == SplitInstallSessionStatus.INSTALLED) {
                                    SplitCompat.install(context)
                                    // Enable immediate usage of dynamic feature modules in an instant app context.
                                    SplitInstallHelper.updateAppInfo(context)
                                } else if (splitInstallSessionState.status() == SplitInstallSessionStatus.REQUIRES_USER_CONFIRMATION) {
                                    registerRequiresUserConfirmation(
                                        installMonitor.splitInstallManager!!,
                                        splitInstallSessionState
                                    )
                                }
                                status.value = splitInstallSessionState
                                if (splitInstallSessionState.hasTerminalStatus()) {
                                    installMonitor.splitInstallManager!!.unregisterListener(this)
                                    // UNKNOWN || FAILED || CANCELED
                                    terminateLiveData(status)
                                }
                            }
                        }
                    }
                    splitInstallManager.registerListener(listener)
                }
            }
            .addOnFailureListener { exception ->
                Log.i(
                    "DynamicInstallManager",
                    "Error requesting install of $module: ${exception.message}"
                )
                installMonitor.exception = exception
                status.value = SplitInstallSessionState.create(
                    /* sessionId */ 0,
                    SplitInstallSessionStatus.FAILED,
                    if (exception is SplitInstallException)
                        exception.errorCode
                    else
                        SplitInstallErrorCode.INTERNAL_ERROR,
                    /* bytesDownloaded */ 0,
                    /* totalBytesToDownload */ 0,
                    listOf(module),
                    emptyList()
                )
                terminateLiveData(status)
            }
    }

    suspend fun requestInstall(module: String): SplitInstallSessionState =
        suspendCoroutine { continuation: Continuation<SplitInstallSessionState> ->
            val request = SplitInstallRequest
                .newBuilder()
                .addModule(module)
                .build()
            var requestSessionId: Int
            splitInstallManager.startInstall(request).addOnSuccessListener { sessionId ->
                requestSessionId = sessionId
                if (sessionId == 0) {
                    // The feature is already installed, emit synthetic INSTALLED state.
                    val status = SplitInstallSessionState.create(
                        sessionId,
                        SplitInstallSessionStatus.INSTALLED,
                        SplitInstallErrorCode.NO_ERROR,
                        /* bytesDownloaded */ 0,
                        /* totalBytesToDownload */ 0,
                        listOf(module),
                        emptyList()
                    )
                    continuation.resume(status)
                } else {
                    val listener = object : SplitInstallStateUpdatedListener {
                        override fun onStateUpdate(
                            splitInstallSessionState: SplitInstallSessionState,
                        ) {
                            if (splitInstallSessionState.sessionId() == requestSessionId) {
                                if (splitInstallSessionState.status() == SplitInstallSessionStatus.INSTALLED) {
                                    SplitCompat.install(context)
                                    // Enable immediate usage of dynamic feature modules in an instant app context.
                                    SplitInstallHelper.updateAppInfo(context)
                                } else if (splitInstallSessionState.status() == SplitInstallSessionStatus.REQUIRES_USER_CONFIRMATION) {
                                    registerRequiresUserConfirmation(
                                        splitInstallManager,
                                        splitInstallSessionState
                                    )
                                }
                                if (splitInstallSessionState.hasTerminalStatus()) {
                                    splitInstallManager.unregisterListener(this)
                                    // UNKNOWN || FAILED || CANCELED
                                    continuation.resume(splitInstallSessionState)
                                }
                            }
                        }
                    }
                    splitInstallManager.registerListener(listener)
                }
            }.addOnFailureListener { exception ->
                val error = IllegalStateException("DynamicInstallManager: " +
                        "Error requesting install of $module: ${exception.message}",
                    exception)
                continuation.resumeWithException(error)
            }
        }

    fun install(
        module: String,
    ): SplitInstallMonitor {
        val onDemandMonitor = SplitInstallMonitor()
        requestInstall(module, onDemandMonitor)
        return onDemandMonitor
    }

    fun install(
        module: String,
        owner: LifecycleOwner,
        observerSplitInstallSessionState: ObserverSplitInstallSessionState,
    ): SplitInstallMonitor {
        val onDemandMonitor = install(module)
        onDemandMonitor.status.observe(owner, object : Observer<SplitInstallSessionState> {
            override fun onChanged(state: SplitInstallSessionState) {
                when (state.status()) {
                    SplitInstallSessionStatus.INSTALLED ->
                        observerSplitInstallSessionState.onInstalled(onDemandMonitor)
                    SplitInstallSessionStatus.FAILED ->
                        observerSplitInstallSessionState.onFailed(onDemandMonitor)
                    SplitInstallSessionStatus.CANCELED ->
                        observerSplitInstallSessionState.onCanceled(onDemandMonitor)
                    SplitInstallSessionStatus.CANCELING ->
                        observerSplitInstallSessionState.onCanceling(onDemandMonitor)
                    SplitInstallSessionStatus.DOWNLOADED ->
                        observerSplitInstallSessionState.onDownloaded(onDemandMonitor)
                    SplitInstallSessionStatus.DOWNLOADING ->
                        observerSplitInstallSessionState.onDownloading(onDemandMonitor)
                    SplitInstallSessionStatus.INSTALLING ->
                        observerSplitInstallSessionState.onInstalling(onDemandMonitor)
                    SplitInstallSessionStatus.PENDING ->
                        observerSplitInstallSessionState.onPending(onDemandMonitor)
                    SplitInstallSessionStatus.REQUIRES_USER_CONFIRMATION ->
                        observerSplitInstallSessionState.onRequiresUserConfirmation(onDemandMonitor)
                    SplitInstallSessionStatus.UNKNOWN ->
                        observerSplitInstallSessionState.onUnknown(onDemandMonitor)
                }
                // INSTALLED || UNKNOWN || FAILED || CANCELED
                if (state.hasTerminalStatus()) {
                    observerSplitInstallSessionState.onTerminated(onDemandMonitor)
                    onDemandMonitor.status.removeObserver(this)
                }
            }
        })
        return onDemandMonitor
    }

    private object SplitActivityAutoConfiguration : Application.ActivityLifecycleCallbacks {
        fun install(application: Application) {
            application.registerActivityLifecycleCallbacks(this)
        }

        private fun observeRequiresUserConfirmation(activity: Activity) {
            val owner = activity as LifecycleOwner
            onRequiresUserConfirmation.observe(owner, {
                if (it?.second?.status() == SplitInstallSessionStatus.REQUIRES_USER_CONFIRMATION) {
                    val splitInstallManager: SplitInstallManager = it.first
                    val splitInstallSessionState: SplitInstallSessionState = it.second
                    onRequiresUserConfirmation.postValue(null)
                    splitInstallManager.startConfirmationDialogForResult(
                        splitInstallSessionState,
                        activity,
                        REQUEST_CODE_REQUIRES_USER_CONFIRMATION
                    )
                }
            })
        }

        private fun removeObserverRequiresUserConfirmation(owner: LifecycleOwner) {
            onRequiresUserConfirmation.removeObservers(owner)
        }

        override fun onActivityCreated(activity: Activity, bundle: Bundle?) {
            if (SplitCompat.installActivity(activity) && activity is LifecycleOwner) {
                observeRequiresUserConfirmation(activity)
            }
        }

        override fun onActivityStarted(activity: Activity) {}
        override fun onActivityResumed(activity: Activity) {}
        override fun onActivityPaused(activity: Activity) {}
        override fun onActivityStopped(activity: Activity) {}
        override fun onActivitySaveInstanceState(activity: Activity, bundle: Bundle) {}
        override fun onActivityDestroyed(activity: Activity) {
            removeObserverRequiresUserConfirmation(activity as LifecycleOwner)
        }
    }

    interface ObserverSplitInstallSessionState {
        fun onUnknown(state: SplitInstallMonitor) {}

        fun onRequiresUserConfirmation(state: SplitInstallMonitor) {}

        fun onPending(state: SplitInstallMonitor) {}

        fun onInstalling(state: SplitInstallMonitor) {}

        fun onDownloading(state: SplitInstallMonitor) {}

        fun onDownloaded(state: SplitInstallMonitor) {}

        fun onCanceling(state: SplitInstallMonitor) {}

        fun onCanceled(state: SplitInstallMonitor)

        fun onFailed(state: SplitInstallMonitor)

        fun onInstalled(state: SplitInstallMonitor)

        fun onTerminated(state: SplitInstallMonitor) {}
    }
}