package com.example.profile

import android.os.Bundle
import com.core.base.BaseHostActivity
import com.core.base.BaseProvider

class ProfileHostActivity : BaseHostActivity<BaseProvider>(R.navigation.profile_navigation_graph) {
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