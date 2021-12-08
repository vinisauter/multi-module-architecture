package com.core.base

import android.injection.Module
import android.os.Bundle
import androidx.annotation.IdRes
import androidx.annotation.NavigationRes
import androidx.navigation.NavDestination
import androidx.navigation.Navigator
import com.example.app.R
import com.example.journey.JourneyNavigator

abstract class ModuleController(
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

    override fun customNavigators(): List<Navigator<out NavDestination>> {
        val launcherNavigator = JourneyNavigator(
            navController.context,
            navController.navigatorProvider,
            navController.navInflater,
            R.navigation.app_navigation_graph
        )
        return listOf(launcherNavigator)
    }
}