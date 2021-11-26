package com.example.app

import android.os.Bundle
import com.core.base.NavigationActivity

class AppNavigationActivity : NavigationActivity(
    graphResId = R.navigation.app_navigation_graph,
    startDestination = R.id.splash_fragment
) {
    val deepLink by lazy { intent.data }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //TODO handle deepLink
    }
}
