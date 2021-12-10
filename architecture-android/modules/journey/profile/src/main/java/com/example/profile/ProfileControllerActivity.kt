package com.example.profile

import android.injection.Module
import android.injection.module
import android.os.Bundle
import com.core.base.ModuleControllerActivity

class ProfileControllerActivity : ModuleControllerActivity(R.navigation.profile_navigation_graph) {
    override fun dependencies(): Module = module("profile") {}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO ADD MODULES DEPENDENCIES
    }

    override fun onDestroy() {
        super.onDestroy()
        // TODO REMOVE MODULES DEPENDENCIES
    }
}