package com.core.base

import android.injection.Module
import androidx.annotation.IdRes
import androidx.annotation.NavigationRes
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.navigation.NavDestination
import androidx.navigation.Navigator
import com.example.app.R
import com.example.journey.JourneyNavigator

abstract class ModuleControllerActivity(
    @NavigationRes override val graphResId: Int,
    @IdRes override val startDestination: Int = DEFAULT_START_DESTINATION
) : NavigationActivity(graphResId, startDestination) {
    private var module: Module? = null
    abstract fun dependencies(): Module?

//    //TODO: InjectionViewModelFactory to DefaultViewModelProviderFactory?
//    private lateinit var mDefaultFactory: ViewModelProvider.Factory
//    override fun getDefaultViewModelProviderFactory(): ViewModelProvider.Factory {
//        //return super.getDefaultViewModelProviderFactory()
//        if (!::mDefaultFactory.isInitialized) {
//            mDefaultFactory = InjectionViewModelFactory(
//                application,
//                this,
//                if (intent != null) intent.extras else null
//            )
//        }
//        return mDefaultFactory
//    }

    init {
        lifecycle.addObserver(LifecycleEventObserver { _, event ->
            if (event == Lifecycle.Event.ON_CREATE) {
                module = dependencies()
            } else if (event == Lifecycle.Event.ON_DESTROY) {
                val shouldClear = !isChangingConfigurations
                if (shouldClear) {
                    module?.clear()
                    module = null
                }
            }
        })
    }

    override fun customNavigators(): List<Navigator<out NavDestination>> {
        val launcherNavigator = JourneyNavigator(
            navController.context,
            navController.navigatorProvider,
            navController.navInflater,
            R.navigation.app_navigation_graph
        )
        return listOf(launcherNavigator)
    }
}