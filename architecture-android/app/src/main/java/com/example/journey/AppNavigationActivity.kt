package com.example.journey

import android.content.Context
import android.content.Intent
import androidx.annotation.IdRes
import com.core.base.NavigationActivity
import com.example.app.R

class AppNavigationActivity : NavigationActivity(R.navigation.app_navigation_graph) {
    override val startDestination: Int by lazy {
        intent.getIntExtra(START_DESTINATION, DEFAULT_START_DESTINATION)
    }

    companion object {
        private const val START_DESTINATION = "START_DESTINATION"
        fun open(
            context: Context,
            // TODO: Replace IdRes with Enumerated Annotations?
            @IdRes startDestination: Int = DEFAULT_START_DESTINATION,
            clearStack: Boolean = false
        ) {
            context.startActivity(Intent(context, NavigationActivity::class.java).apply {
                putExtra(START_DESTINATION, startDestination)
                if (clearStack) {
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
                }
            })
        }
    }
}
