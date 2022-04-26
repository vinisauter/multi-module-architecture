package com.example.app

import android.os.Bundle
import com.core.base.BaseHostActivity
import com.core.base.BaseViewModelFactory

class AppNavigationActivity : BaseHostActivity<BaseViewModelFactory.Provider>(
    graphResId = R.navigation.app_navigation_graph,
    startDestination = R.id.splash
) {
    val deepLink by lazy { intent.data }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //TODO handle deepLink
    }

    override fun getDependencyProvider(): BaseViewModelFactory.Provider =
        BaseViewModelFactory.Provider()
}
