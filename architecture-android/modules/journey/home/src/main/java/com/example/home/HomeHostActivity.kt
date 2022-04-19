package com.example.home

import android.os.Bundle
import com.core.base.BaseHostActivity
import com.core.base.BaseProvider

class HomeHostActivity : BaseHostActivity<BaseProvider>(R.navigation.home_navigation_graph) {
    override val dependenciesProvider: BaseProvider?
        get() = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO ADD MODULES DEPENDENCIES
    }

    override fun onDestroy() {
        super.onDestroy()
        // TODO REMOVE MODULES DEPENDENCIES
    }
}