package com.example.home

import android.injection.Module
import android.os.Bundle
import com.core.base.BaseHostActivity

class HomeHostActivity : BaseHostActivity(R.navigation.home_navigation_graph) {
    override fun Module.dependencies() {}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO ADD MODULES DEPENDENCIES
    }

    override fun onDestroy() {
        super.onDestroy()
        // TODO REMOVE MODULES DEPENDENCIES
    }
}