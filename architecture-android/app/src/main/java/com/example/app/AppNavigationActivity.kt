package com.example.app

import android.injection.Module
import android.injection.module
import android.os.Bundle
import com.core.base.ModuleController

class AppNavigationActivity : ModuleController(
    graphResId = R.navigation.app_navigation_graph,
    startDestination = R.id.splash
) {
    val deepLink by lazy { intent.data }
    override fun dependencies(): Module = module("app") {}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //TODO handle deepLink
    }
}
