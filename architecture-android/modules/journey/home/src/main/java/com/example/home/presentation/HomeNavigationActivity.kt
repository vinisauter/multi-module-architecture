package com.example.home.presentation

import android.os.Bundle
import com.core.base.NavigationActivity
import com.example.home.R

class HomeNavigationActivity : NavigationActivity(R.navigation.home_navigation_graph){
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        koin.load modules{ TODO }
    }

    override fun onDestroy() {
        super.onDestroy()
//        koin.unload modules{ TODO }
    }
}