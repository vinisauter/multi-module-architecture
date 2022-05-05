package com.core.base

import androidx.annotation.IdRes
import androidx.annotation.NavigationRes
import androidx.lifecycle.ViewModelProvider
import com.example.app.R

abstract class BaseHostActivity<BP : BaseViewModelFactory.Provider>(
    @NavigationRes override val graphResId: Int,
    @IdRes override val startDestination: Int = DEFAULT_START_DESTINATION
) : BaseNavigationActivity(graphResId, startDestination) {

    override val appNavigationGraph: Int = R.navigation.app_navigation_graph

    abstract fun getDependencyProvider(): BP

    private lateinit var mDefaultFactory: ViewModelProvider.Factory
    override fun getDefaultViewModelProviderFactory(): ViewModelProvider.Factory {
        if (!::mDefaultFactory.isInitialized) {
            mDefaultFactory = BaseViewModelFactory(
                application = application,
                savedStateRegistryOwner = this,
                defaultArgs = if (intent != null) intent.extras else null,
                provider = getDependencyProvider()
            )
        }
        return mDefaultFactory
    }
}