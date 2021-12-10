package com.example.home

import android.injection.Module
import android.injection.module
import android.os.Bundle
import com.core.base.ModuleControllerActivity

class HomeNavigationActivity : ModuleControllerActivity(R.navigation.home_navigation_graph) {
    override fun dependencies(): Module = module("home") {}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO ADD MODULES DEPENDENCIES
    }

    override fun onDestroy() {
        super.onDestroy()
        // TODO REMOVE MODULES DEPENDENCIES
    }
}