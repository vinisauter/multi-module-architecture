package com.example.journey

import android.content.Context
import android.util.AttributeSet
import androidx.navigation.*
import androidx.navigation.NavGraph.Companion.findStartDestination
import com.example.app.R

/**
 * Navigator for `module`.
 *
 * Use it for navigating to app.
 */
@Navigator.Name("module")
class ModuleNavigator(
    private val navigatorProvider: NavigatorProvider,
    private val navInflater: NavInflater,
    private val graphId: Int,
) : Navigator<ModuleNavigator.ModuleDestination>() {

    override fun createDestination(): ModuleDestination = ModuleDestination(this)

    override fun navigate(
        entries: List<NavBackStackEntry>,
        navOptions: NavOptions?,
        navigatorExtras: Extras?
    ) {
        for (entry in entries) {
            navigate(entry, navOptions, navigatorExtras)
        }
    }

    private fun navigate(
        entry: NavBackStackEntry,
        navOptions: NavOptions?,
        navigatorExtras: Extras?
    ) {
        val module = entry.destination as ModuleDestination

        val includedNav = navInflater.inflate(graphId)
        includedNav.id = module.id
        val outerNav = module.parent
            ?: throw IllegalStateException(
                "The module destination with id ${module.displayName} " +
                        "does not have a parent. Make sure it is attached to a NavGraph."
            )
        val destinationId = module.destiny
        var resolvedDestination: NavDestination? = null
        if (module.toStart) resolvedDestination = includedNav.findStartDestination()
        val iterator = includedNav.iterator()
        while (iterator.hasNext()) {
            val nextDestination = iterator.next()
            iterator.remove()
            outerNav.addDestination(nextDestination)
            if (destinationId == nextDestination.id) {
                resolvedDestination = nextDestination
            }
        }
        if (resolvedDestination == null)
            throw IllegalStateException(
                "The module destination with id ${module.displayName} " +
                        "does not have a matching destiny (${module.destiny}). Make sure it it exists on app_navigation_graph."
            )
        val destination = resolvedDestination
        val navigator: Navigator<NavDestination> = navigatorProvider[destination.navigatorName]
        val newGraphEntry = state.createBackStackEntry(destination, entry.arguments)
        navigator.navigate(listOf(newGraphEntry), navOptions, navigatorExtras)
    }

    class ModuleDestination(
        navigator: ModuleNavigator,
    ) : NavDestination(navigator) {
        var name: String? = null
        var destiny: Int? = null
        var toStart: Boolean = false

        override fun onInflate(context: Context, attrs: AttributeSet) {
            super.onInflate(context, attrs)
            val it = context.resources.obtainAttributes(attrs, R.styleable.ModuleNavigator)
            name = it.getString(R.styleable.ModuleNavigator_android_name)
            destiny = it.getResourceId(R.styleable.ModuleNavigator_destiny, 0)
            toStart = it.getBoolean(R.styleable.ModuleNavigator_toStart, false)
            it.recycle()
        }
    }
}