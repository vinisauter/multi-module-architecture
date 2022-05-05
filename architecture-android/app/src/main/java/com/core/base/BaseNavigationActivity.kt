package com.core.base

import android.os.Bundle
import androidx.annotation.IdRes
import androidx.annotation.NavigationRes
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.NavController
import androidx.navigation.NavDestination
import androidx.navigation.NavGraph
import androidx.navigation.Navigator
import androidx.navigation.fragment.NavHostFragment
import com.example.app.R
import com.example.journey.JourneyNavigator

abstract class BaseNavigationActivity(
    @NavigationRes open val graphResId: Int,
    @IdRes open val startDestination: Int = DEFAULT_START_DESTINATION
) : AppCompatActivity(R.layout.navigation_activity) {
    companion object {
        const val DEFAULT_START_DESTINATION: Int = -1
    }

    abstract val appNavigationGraph: Int
    open lateinit var navController: NavController
    open lateinit var navGraph: NavGraph
    open val navHostFragment: NavHostFragment by lazy {
        supportFragmentManager.findFragmentById(R.id.nav_host_fragment) as NavHostFragment
    }

    open fun customNavigators(): List<Navigator<out NavDestination>> {
        // enable TAG journey to navigation of the module host activity
        // to enable back navigation to R.navigation.app_navigation_graph
        val launcherNavigator = JourneyNavigator(
            navController.context,
            navController.navigatorProvider,
            navController.navInflater,
            appNavigationGraph
        )
        return listOf(launcherNavigator)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val graphInflater = navHostFragment.navController.navInflater
        navController = navHostFragment.navController
        navController.apply {
            for (navigator in customNavigators()) {
                navigatorProvider.addNavigator(navigator)
            }
        }
        navGraph = graphInflater.inflate(graphResId)
        if (startDestination != DEFAULT_START_DESTINATION) {
            navGraph.setStartDestination(startDestination)
        }
        navController.graph = navGraph
    }
}
