package com.example.login

import android.os.Bundle
import com.core.base.NavigationActivity

class LoginNavigationActivity : NavigationActivity(R.navigation.login_navigation_graph) {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO ADD MODULES DEPENDENCIES
    }

    override fun onDestroy() {
        super.onDestroy()
        // TODO REMOVE MODULES DEPENDENCIES
    }
}