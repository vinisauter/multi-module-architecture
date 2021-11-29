package com.example.profile

import android.os.Bundle
import com.core.base.NavigationActivity

class ProfileNavigationActivity : NavigationActivity(R.navigation.profile_navigation_graph) {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO ADD MODULES DEPENDENCIES
    }

    override fun onDestroy() {
        super.onDestroy()
        // TODO REMOVE MODULES DEPENDENCIES
    }
}