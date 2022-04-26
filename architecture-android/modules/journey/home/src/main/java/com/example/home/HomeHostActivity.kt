package com.example.home

import android.os.Bundle
import com.core.base.BaseHostActivity
import com.core.base.BaseViewModelFactory

class HomeHostActivity :
    BaseHostActivity<BaseViewModelFactory.Provider>(R.navigation.home_navigation_graph) {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO ADD MODULES DEPENDENCIES
    }

    override fun onDestroy() {
        super.onDestroy()
        // TODO REMOVE MODULES DEPENDENCIES
    }

    override fun getDependencyProvider(): BaseViewModelFactory.Provider {
        return BaseViewModelFactory.Provider()
    }
}