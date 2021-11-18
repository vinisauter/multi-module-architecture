package com.example.app.base

abstract class BaseLauncher {
    private var started = false
    private val baseAnalytics = mutableMapOf<String,String>()
    private val analytics = mutableMapOf<String,String>()

    fun start(analyticsMap: Map<String,String> = mutableMapOf()){
        if (!started) {
            baseAnalytics.putAll(analyticsMap)
            onStart()
            started = true
        }
    }

    protected abstract fun onStart()

    fun setAnalytics(analyticsMap: Map<String,String>) {
        analytics.putAll(analyticsMap)
    }

    fun clearAnalytics() {
        analytics.clear()
    }

    fun analyticTagFor(key: String): String? {
        analytics[key]?.let {
            return it
        }?:run {
            return baseAnalytics[key]
        }
    }
}