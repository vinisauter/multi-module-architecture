package com.example.app

import android.app.Activity
import android.app.ActivityManager
import android.app.Application
import android.content.Context
import android.content.res.Configuration
import android.os.Bundle
import com.app.logger.Logger
import java.text.MessageFormat

class SuperApplication : Application(), Application.ActivityLifecycleCallbacks {
    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
    }

    override fun onCreate() {
        super.onCreate()
        registerActivityLifecycleCallbacks(this)
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