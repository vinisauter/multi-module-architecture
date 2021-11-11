@file:Suppress("unused")

package com.example.app

import android.app.Activity
import android.app.ActivityManager
import android.app.Application
import android.content.Context
import android.content.res.Configuration
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.StrictModeManager.enableStrictMode
import android.widget.Toast
import com.app.logger.Logger
import com.google.android.play.core.splitcompat.SplitCompat
import java.text.MessageFormat

class SuperApplication : Application(), Application.ActivityLifecycleCallbacks {
    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        // MultiDex.install(this)
    }

    override fun onCreate() {
        if (BuildConfig.DEBUG) {
            enableStrictMode(
                application = this,
                LOGGER = Logger.logger,
                APPLICATION_ID = BuildConfig.APPLICATION_ID,
                penaltyDialog = true,
                enableForThirdParties = false,
                classInstanceLimit = mapOf(
//                    Pair(SingleInstance::class.java, 1)
//                    Pair(Cache::class.java, 1)
                )
            )
        }
        super.onCreate()
        registerActivityLifecycleCallbacks(this)

//        val logsFolder = File(filesDir, "logs")
//        if (!logsFolder.exists()) {
//            logsFolder.mkdirs()
//        }
//        Logger.fileHandler =
//            LoggerFileHandler(
//                app = this,
//                file = File(logsFolder, "app-log.txt"),
//                authority = BuildConfig.APPLICATION_ID,
//                appVersion = "${BuildConfig.BUILD_TYPE} ${BuildConfig.VERSION_CODE} - ${BuildConfig.VERSION_NAME}",
//                codeVersion = "${BuildConfig.BUILD_MACHINE_NAME} ${BuildConfig.GIT_BRANCH} ${BuildConfig.GIT_COMMIT}"
//            )
    }

    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
        val intent = activity.intent
        val action = if (intent.action != null) intent.action else ""
        Logger.log("lifecycle: onActivityCreated", activity.javaClass.simpleName + " " + action)
    }

    override fun onActivityStarted(activity: Activity) {
        Logger.log("lifecycle: onActivityStarted", activity.javaClass.simpleName)
    }

    override fun onActivityResumed(activity: Activity) {
        Logger.log("lifecycle: onActivityResumed", activity.javaClass.simpleName)
    }

    override fun onActivityPaused(activity: Activity) {
        Logger.log("lifecycle: onActivityPaused", activity.javaClass.simpleName)
    }

    override fun onActivityStopped(activity: Activity) {
        Logger.log("lifecycle: onActivityStopped", activity.javaClass.simpleName)
    }

    override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {
        Logger.log("lifecycle: onActivitySaveInstanceState", activity.javaClass.simpleName)
    }

    override fun onActivityDestroyed(activity: Activity) {
        Logger.log("lifecycle: onActivityDestroyed", activity.javaClass.simpleName)
    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
        Logger.log("lifecycle: app", "Application.onConfigurationChanged")
    }

    override fun onLowMemory() {
        super.onLowMemory()
        val memoryInfo = getMemoryInfo()
        Logger.log(
            "lifecycle: app", MessageFormat.format(
                "Application.onLowMemory: Memory Info | {0} | {1} | {2} | {3}",
                memoryInfo.availMem,
                memoryInfo.totalMem,
                memoryInfo.threshold,
                memoryInfo.lowMemory
            )
        )
    }

    override fun onTrimMemory(level: Int) {
        super.onTrimMemory(level)
        Logger.log("lifecycle: app", "Application.onTrimMemory")
    }

    override fun onTerminate() {
        super.onTerminate()
        Logger.log("lifecycle: app", "Application.onTerminate")
    }

    private fun getMemoryInfo(): ActivityManager.MemoryInfo {
        val memoryInfo = ActivityManager.MemoryInfo()
        val activityManager = getSystemService(ACTIVITY_SERVICE) as ActivityManager
        activityManager.getMemoryInfo(memoryInfo)
        return memoryInfo
    }
}

fun Context.longToast(text: CharSequence) {
    Handler(Looper.getMainLooper()).post { Toast.makeText(this, text, Toast.LENGTH_LONG).show() }
}