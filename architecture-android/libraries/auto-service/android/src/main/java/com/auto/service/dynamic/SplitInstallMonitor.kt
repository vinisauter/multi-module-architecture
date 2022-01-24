package com.auto.service.dynamic

import androidx.annotation.RestrictTo
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.android.play.core.splitinstall.SplitInstallManager
import com.google.android.play.core.splitinstall.SplitInstallSessionState

/**
 * Monitor installation progress of dynamic feature modules.
 * This class enables you to subscribe to the current installation state via [.getStatus].
 * You also can perform various checks on installation state directly through this monitor.
 *
 * In order to enable installation and monitoring of progress you'll have to provide an instance
 * of this class to [Dynamic Extras].
 */
class SplitInstallMonitor {

    /**
     * The occurred exception, if any.
     */
    var exception: Exception? = null
        internal set

    /**
     * Get a LiveData of [SplitInstallSessionState] with updates on the installation progress.
     */
    val status: LiveData<SplitInstallSessionState> = MutableLiveData()

    /**
     * Check whether an installation is required.
     *
     * If this returns `true`, you should observe the LiveData returned by
     * [status] for installation updates and handle them accordingly.
     *
     * @return `true` if installation is required, `false` otherwise.
     */
    var isInstallRequired = false
        internal set(installRequired) {
            field = installRequired
            if (installRequired) {
                isUsed = true
            }
        }

    /**
     * The session id from Play Core for this installation session.
     */
    var sessionId = 0
        internal set

    /**
     * The [SplitInstallManager] used to monitor the installation if any was set.
     */
    internal var splitInstallManager: SplitInstallManager? = null

    /**
     * `true` if the monitor has been used to request an install, else
     * `false`.
     * @hide
     */
    @get:RestrictTo(RestrictTo.Scope.LIBRARY)
    internal var isUsed = false
        private set

    /**
     * Cancel the current split installation session in the SplitInstallManager.
     */
    fun cancelInstall() {
        val splitInstallManager = splitInstallManager
        if (splitInstallManager != null && sessionId != 0) {
            splitInstallManager.cancelInstall(sessionId)
        }
    }
}