package com.core.base

import androidx.annotation.IdRes
import androidx.annotation.NavigationRes
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavDestination
import androidx.navigation.Navigator
import com.example.app.R
import com.example.journey.JourneyNavigator

abstract class BaseHostActivity<BP : BaseViewModelFactory.Provider>(
    @NavigationRes override val graphResId: Int,
    @IdRes override val startDestination: Int = DEFAULT_START_DESTINATION
) : BaseNavigationActivity(graphResId, startDestination) {

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

    override fun customNavigators(): List<Navigator<out NavDestination>> {
        // enable TAG journey to navigation of the module host activity
        // to enable back navigation to R.navigation.app_navigation_graph
        val launcherNavigator = JourneyNavigator(
            navController.context,
            navController.navigatorProvider,
            navController.navInflater,
            R.navigation.app_navigation_graph
        )
        return listOf(launcherNavigator)
    }
}