package com.core.extensions

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.Parcelable
import androidx.annotation.IdRes
import androidx.fragment.app.Fragment
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.Observer
import androidx.navigation.*
import androidx.navigation.dynamicfeatures.DynamicExtras
import androidx.navigation.dynamicfeatures.DynamicInstallMonitor
import androidx.navigation.fragment.findNavController
import com.core.base.NavigationActivity
import com.google.android.play.core.splitinstall.SplitInstallSessionState
import com.google.android.play.core.splitinstall.model.SplitInstallSessionStatus
import kotlinx.parcelize.Parcelize

val Fragment.deepLinkIntent: Intent?
    get() = (arguments?.get(NavController.KEY_DEEP_LINK_INTENT) as Intent?)

fun Fragment.deepLinkUri(): Lazy<Uri?> = lazy { deepLinkIntent?.data }

private fun navigate(
    lifecycleOwner: LifecycleOwner,
    navController: NavController,
    @IdRes resId: Int,
    arguments: Bundle? = null,
    navOptions: NavOptions? = null,
    statusObserver: SplitInstallStatusObserver? = null
) {
    val installMonitor = DynamicInstallMonitor()
    // TODO? validate if destination is Activity?
    val extras = ActivityNavigator.Extras.Builder()
        .addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP)
        .build()
    val dynamicExtras = DynamicExtras(installMonitor, extras)

    val isPopUpTo = arguments?.getBoolean("popBackTo") == true
    val isInclusive = arguments?.getBoolean("inclusive") == true
    val isSaveState = arguments?.getBoolean("saveState") == true
    val finalNavOptions: NavOptions? =
        if (navOptions == null && isPopUpTo) {
            NavOptions.Builder().setPopUpTo(
                destinationId = resId,
                inclusive = isInclusive,
                saveState = isSaveState
            ).build()
        } else null

    navController.navigate(
        if (isPopUpTo) 0 else resId,
        arguments,
        finalNavOptions,
        dynamicExtras
    )
    installMonitor.observe(lifecycleOwner, statusObserver)
}

fun Fragment.navigate(
    @IdRes destinationId: Int,
    args: Bundle? = null,
    navOptions: NavOptions? = null,
    statusObserver: SplitInstallStatusObserver? = null
) {
    val navController = findNavController()
    navigate(
        viewLifecycleOwner,
        navController,
        destinationId,
        args,
        navOptions,
        statusObserver
    )
}

fun Fragment.navigate(
    destination: NavDirections,
    navOptions: NavOptions? = null,
    statusObserver: SplitInstallStatusObserver? = null
) {
    val navController = findNavController()
    navigate(
        viewLifecycleOwner,
        navController,
        destination.actionId,
        destination.arguments,
        navOptions,
        statusObserver
    )
}

fun NavigationActivity.navigate(
    @IdRes destinationId: Int,
    args: Bundle? = null,
    navOptions: NavOptions? = null,
    statusObserver: SplitInstallStatusObserver? = null
) {
    navigate(
        this,
        navController,
        destinationId,
        args,
        navOptions,
        statusObserver
    )
}

fun NavigationActivity.navigate(
    destination: NavDirections,
    navOptions: NavOptions? = null,
    statusObserver: SplitInstallStatusObserver? = null
) {
    navigate(
        this,
        navController,
        destination.actionId,
        destination.arguments,
        navOptions,
        statusObserver
    )
}

fun DynamicInstallMonitor.observe(
    owner: LifecycleOwner,
    statusObserver: SplitInstallStatusObserver? = null
) {
    val installMonitor = this
    if (statusObserver != null)
        status.observe(owner, object : Observer<SplitInstallSessionState> {
            override fun onChanged(state: SplitInstallSessionState) {
                when (state.status()) {
                    SplitInstallSessionStatus.INSTALLED ->
                        statusObserver.onInstalled(installMonitor)
                    SplitInstallSessionStatus.FAILED ->
                        statusObserver.onFailed(installMonitor)
                    SplitInstallSessionStatus.CANCELED ->
                        statusObserver.onCanceled(installMonitor)
                    SplitInstallSessionStatus.CANCELING ->
                        statusObserver.onCanceling(installMonitor)
                    SplitInstallSessionStatus.DOWNLOADED ->
                        statusObserver.onDownloaded(installMonitor)
                    SplitInstallSessionStatus.DOWNLOADING ->
                        statusObserver.onDownloading(installMonitor)
                    SplitInstallSessionStatus.INSTALLING ->
                        statusObserver.onInstalling(installMonitor)
                    SplitInstallSessionStatus.PENDING ->
                        statusObserver.onPending(installMonitor)
                    SplitInstallSessionStatus.REQUIRES_USER_CONFIRMATION ->
                        statusObserver.onRequiresUserConfirmation(installMonitor)
                    SplitInstallSessionStatus.UNKNOWN ->
                        statusObserver.onUnknown(installMonitor)
                }
                // INSTALLED || UNKNOWN || FAILED || CANCELED
                if (state.hasTerminalStatus()) {
                    statusObserver.onTerminated(installMonitor)
                    installMonitor.status.removeObserver(this)
                }
            }
        })
}

interface SplitInstallStatusObserver {
    fun onUnknown(state: DynamicInstallMonitor) {}

    fun onRequiresUserConfirmation(state: DynamicInstallMonitor) {}

    fun onPending(state: DynamicInstallMonitor) {}

    fun onInstalling(state: DynamicInstallMonitor) {}

    fun onDownloading(state: DynamicInstallMonitor) {}

    fun onDownloaded(state: DynamicInstallMonitor) {}

    fun onCanceling(state: DynamicInstallMonitor) {}

    fun onCanceled(state: DynamicInstallMonitor)

    fun onFailed(state: DynamicInstallMonitor)

    fun onInstalled(state: DynamicInstallMonitor)

    fun onTerminated(state: DynamicInstallMonitor) {}
}

val Fragment.currentDestinationId: Int
    get() {
        val navController = findNavController()
        val currentDestination: NavDestination = navController.currentDestination!!
        return currentDestination.id
    }

fun Fragment.popBackTo(
    @IdRes destinationId: Int,
    inclusive: Boolean = false,
    saveState: Boolean = true
) {
    val navController = findNavController()
    navController.popBackStack(destinationId, inclusive, saveState)
}

fun Fragment.popBackTo(to: PopBackTo) {
    popBackTo(to.destinationId, to.inclusive, to.saveState)
}

fun Fragment.redirectTo(
    @IdRes destinationId: Int,
    inclusive: Boolean = false,
    saveState: Boolean = true
): PopBackTo {
    return PopBackTo(destinationId, inclusive, saveState)
}

fun Fragment.redirectToThis(
    inclusive: Boolean = false,
    saveState: Boolean = true
): PopBackTo {
    return redirectTo(currentDestinationId, inclusive, saveState)
}

@Parcelize
open class PopBackTo(
    @IdRes val destinationId: Int,
    val inclusive: Boolean = false,
    val saveState: Boolean = true
) : Direction(destinationId, Bundle().apply {
    putBoolean("inclusive", inclusive)
    putBoolean("saveState", saveState)
    putBoolean("popBackTo", true)
}), Parcelable

@Parcelize
open class Direction(
    override val actionId: Int,
    override val arguments: Bundle
) : NavDirections, Parcelable
