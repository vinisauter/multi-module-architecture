package com.core.base

import android.injection.Module
import android.os.Bundle
import androidx.annotation.IdRes
import androidx.annotation.NavigationRes

abstract class ModuleNavigationActivity(
    @NavigationRes override val graphResId: Int,
    @IdRes override val startDestination: Int = DEFAULT_START_DESTINATION
) : NavigationActivity(graphResId, startDestination) {
    private lateinit var module: Module
    abstract fun dependencies(): Module
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        module = dependencies()
    }

    override fun onDestroy() {
        super.onDestroy()
        module.clear()
    }
}