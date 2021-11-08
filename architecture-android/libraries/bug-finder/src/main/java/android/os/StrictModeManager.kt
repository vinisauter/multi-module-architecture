package android.os

import android.app.AlertDialog
import android.app.Application
import android.os.strictmode.Violation
import java.util.concurrent.Executors
import java.util.logging.Level
import java.util.logging.Logger


@Suppress("unused")
object StrictModeManager {

    @JvmOverloads
    fun enableStrictMode(
        application: Application,
        LOGGER: Logger? = null,
        APPLICATION_ID: String = "",
        enableForThirdParties: Boolean = false,
        penaltyDialog: Boolean = false,
        classInstanceLimit: Map<Class<*>, Int> = mapOf()
    ) {
        val threadPolicyBuilder: StrictMode.ThreadPolicy.Builder = StrictMode.ThreadPolicy.Builder()
        val vmPolicyBuilder: StrictMode.VmPolicy.Builder = StrictMode.VmPolicy.Builder()
        for (entry in classInstanceLimit.entries) {
            vmPolicyBuilder.setClassInstanceLimit(entry.key, entry.value)
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            threadPolicyBuilder.penaltyListener(
                Executors.newFixedThreadPool(5),
                { v: Violation ->
                    val stackTrace = v.stackTrace
                    var isCodeFromApp = false
                    for (stackTraceElement in stackTrace) {
                        if (stackTraceElement.toString().contains(APPLICATION_ID)) {
                            isCodeFromApp = true
                            break
                        }
                    }
                    val error = v.fillInStackTrace()
                    error.stackTrace = stackTrace
                    val bug: Bug
                    when {
                        isCodeFromApp -> {
                            bug = Bug("THREAD POLICY BUG FOUND", error)
                            bug.stackTrace = arrayOfNulls(0)
                            LOGGER?.log(Level.SEVERE, "" + bug.localizedMessage, bug)
                        }
                        enableForThirdParties -> {
                            bug = Bug("THREAD POLICY BUG FOUND FROM LIB", error)
                            bug.stackTrace = arrayOfNulls(0)
                            LOGGER?.log(Level.SEVERE, "" + bug.localizedMessage, bug)
                        }
                        else -> {
                            return@penaltyListener
                        }
                    }
                    if (penaltyDialog) {
                        val message = bug.messageStackTrace
                        onMainThread {
                            AlertDialog.Builder(application)
                                .setMessage(message)
                                .setPositiveButton("Ok", null)
                                .show()
                        }
                    }
                })
        } else {
            threadPolicyBuilder.penaltyLog()
            threadPolicyBuilder.penaltyDropBox()
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            vmPolicyBuilder.penaltyListener(
                Executors.newFixedThreadPool(5),
                { v: Violation ->
                    val stackTrace = v.stackTrace
                    var isCodeFromApp = false
                    for (stackTraceElement in stackTrace) {
                        if (stackTraceElement.toString().contains(APPLICATION_ID)) {
                            isCodeFromApp = true
                            break
                        }
                    }
                    val error = v.fillInStackTrace()
                    error.stackTrace = stackTrace
                    val bug: Bug
                    when {
                        isCodeFromApp -> {
                            bug = Bug("VIRTUAL MACHINE POLICY BUG FOUND", error)
                            bug.stackTrace = arrayOfNulls(0)
                            LOGGER?.log(Level.SEVERE, "" + bug.localizedMessage, bug)
                        }
                        enableForThirdParties -> {
                            bug = Bug("VIRTUAL MACHINE POLICY BUG FOUND FROM LIB", error)
                            bug.stackTrace = arrayOfNulls(0)
                            LOGGER?.log(Level.SEVERE, "" + bug.localizedMessage, bug)
                        }
                        else -> {
                            return@penaltyListener
                        }
                    }
                    if (penaltyDialog) {
                        val message = bug.messageStackTrace
                        onMainThread {
                            AlertDialog.Builder(application)
                                .setMessage(message)
                                .setPositiveButton("Ok", null)
                                .show()
                        }
                    }
                })
        } else {
            vmPolicyBuilder.penaltyLog()
            vmPolicyBuilder.penaltyDropBox()
        }
        StrictMode.setThreadPolicy(threadPolicyBuilder.build())
        StrictMode.setVmPolicy(vmPolicyBuilder.build())
    }

    private fun onMainThread(runnable: Runnable) {
        if (isMainThread()) {
            runnable.run()
        } else {
            Handler(Looper.getMainLooper()).post(runnable)
        }
    }

    private fun isMainThread(): Boolean {
        return Looper.getMainLooper().thread === Thread.currentThread()
    }
}
