package com.example.home

import android.os.Bundle
import com.core.base.NavigationActivity

class HomeNavigationActivity : NavigationActivity(R.navigation.home_navigation_graph) {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO ADD MODULES DEPENDENCIES
    }

    override fun onDestroy() {
        super.onDestroy()
        // TODO REMOVE MODULES DEPENDENCIES
    }
}