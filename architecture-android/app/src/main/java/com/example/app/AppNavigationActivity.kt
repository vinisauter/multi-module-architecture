package com.example.app

import android.injection.Module
import android.os.Bundle
import com.core.base.ModuleHostActivity

class AppNavigationActivity : ModuleHostActivity(
    graphResId = R.navigation.app_navigation_graph,
    startDestination = R.id.splash
) {
    val deepLink by lazy { intent.data }
    override fun Module.dependencies() {}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //TODO handle deepLink
    }
}
