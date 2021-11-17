package com.navigationapp

import androidx.navigation.NavDirections
import com.example.app.NavGraphDirections

enum class ActionsGlobal {
    LOGIN_GRAPH,
    HOME_GRAPH,
    PROFILE_GRAPH,
    SPLASH_GRAPH,
    DEFAULT_FRAGMENT;

    fun value(): NavDirections {
        NavGraphDirections.also {
            return when (this) {
                LOGIN_GRAPH -> it.actionGlobalLoginGraph()
                HOME_GRAPH -> it.actionGlobalHomeGraph()
                PROFILE_GRAPH -> it.actionGlobalProfileGraph()
                SPLASH_GRAPH -> it.actionGlobalSplashFragment()
                else -> NavGraphDirections.actionGlobalHomeGraph()
            }
        }
    }
}
