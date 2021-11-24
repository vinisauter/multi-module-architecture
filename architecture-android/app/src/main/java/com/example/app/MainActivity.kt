package com.example.app

import com.core.base.NavigationActivity

class MainActivity : NavigationActivity(R.navigation.app_navigation_graph) {
    val deepLink by lazy { intent.data }
}
