package com.core.extensions

import android.content.Intent
import android.os.Bundle
import androidx.annotation.IdRes
import androidx.fragment.app.Fragment
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.Observer
import androidx.navigation.NavController
import androidx.navigation.NavDirections
import androidx.navigation.NavOptions
import androidx.navigation.dynamicfeatures.DynamicExtras
import androidx.navigation.dynamicfeatures.DynamicInstallMonitor
import androidx.navigation.fragment.findNavController
import com.core.base.NavigationActivity
import com.google.android.play.core.splitinstall.SplitInstallSessionState
import com.google.android.play.core.splitinstall.model.SplitInstallSessionStatus

fun Fragment.navigate(
    @IdRes destinationId: Int,
    args: Bundle? = null,
    navOptions: NavOptions? = null,
    statusObserver: SplitInstallStatusObserver? = null
) {
    val navController = findNavController()
    val installMonitor = DynamicInstallMonitor()
    val dynamicExtras = DynamicExtras(installMonitor)
    navController.navigate(destinationId, args, navOptions, dynamicExtras)
    installMonitor.observe(viewLifecycleOwner, statusObserver)
}

val Fragment.deepLinkIntent: Intent?
    get() = (arguments?.get(NavController.KEY_DEEP_LINK_INTENT) as Intent?)

fun Fragment.navigate(
    destinationId: NavDirections,
    navOptions: NavOptions? = null,
    statusObserver: SplitInstallStatusObserver? = null
) {
    val navController = findNavController()
    val installMonitor = DynamicInstallMonitor()
    val dynamicExtras = DynamicExtras(installMonitor)
    navController.navigate(
        destinationId.actionId,
        destinationId.arguments,
        navOptions,
        dynamicExtras
    )
    installMonitor.observe(viewLifecycleOwner, statusObserver)
}

fun NavigationActivity.navigate(
    @IdRes destinationId: Int,
    args: Bundle? = null,
    navOptions: NavOptions? = null,
    statusObserver: SplitInstallStatusObserver? = null
) {
    val installMonitor = DynamicInstallMonitor()
    val dynamicExtras = DynamicExtras(installMonitor)
    navController.navigate(destinationId, args, navOptions, dynamicExtras)
    installMonitor.observe(this, statusObserver)
}

fun NavigationActivity.navigate(
    destinationId: NavDirections,
    navOptions: NavOptions? = null,
    statusObserver: SplitInstallStatusObserver? = null
) {
    val installMonitor = DynamicInstallMonitor()
    val dynamicExtras = DynamicExtras(installMonitor)
    navController.navigate(
        destinationId.actionId,
        destinationId.arguments,
        navOptions,
        dynamicExtras
    )
    installMonitor.observe(this, statusObserver)
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