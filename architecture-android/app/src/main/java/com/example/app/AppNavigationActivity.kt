package com.example.app

import android.injection.Module
import android.os.Bundle
import com.core.base.ModuleControllerActivity

class AppNavigationActivity : ModuleControllerActivity(
    graphResId = R.navigation.app_navigation_graph,
    startDestination = R.id.splash
) {
    val deepLink by lazy { intent.data }
    override fun dependencies(): Module? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //TODO handle deepLink
    }
}
