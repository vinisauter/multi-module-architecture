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
@Navigator.Name("journey")
class JourneyNavigator(
    private val context: Context,
    private val navigatorProvider: NavigatorProvider,
    private val navInflater: NavInflater,
    private val graphId: Int,
) : Navigator<JourneyNavigator.ModuleDestination>() {

    override fun createDestination(): ModuleDestination = ModuleDestination(this, graphId)

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
        val destinationId = module.destiny
        val outerNav = module.parent
            ?: throw IllegalStateException(
                "The module destination with id ${module.displayName} " +
                        "does not have a parent. Make sure it is attached to a NavGraph."
            )
        var resolvedDestination: NavDestination? = outerNav.findNode(destinationId)
        if (resolvedDestination != null) {
            val navigator: Navigator<NavDestination> =
                navigatorProvider[resolvedDestination.navigatorName]
            val newGraphEntry = state.createBackStackEntry(resolvedDestination, entry.arguments)
            navigator.navigate(listOf(newGraphEntry), navOptions, navigatorExtras)
        } else {
            val includedNav = navInflater.inflate(graphId)
            includedNav.id = module.id
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
            if (resolvedDestination == null) throw IllegalStateException(
                "The module destination with id ${module.displayName} does not have a matching " +
                        "destiny (${context.resources.getResourceName(module.destiny)}).\n" +
                        "Make sure it it exists on ${context.resources.getResourceEntryName(graphId)}."
            )
            val destination = resolvedDestination
            val navigator: Navigator<NavDestination> = navigatorProvider[destination.navigatorName]
            val newGraphEntry = state.createBackStackEntry(destination, entry.arguments)
            navigator.navigate(listOf(newGraphEntry), navOptions, navigatorExtras)
        }
    }

    class ModuleDestination(
        navigator: JourneyNavigator,
        private val graphId: Int
    ) : NavDestination(navigator) {
        var destiny: Int = 0
        var toStart: Boolean = false

        override fun onInflate(context: Context, attrs: AttributeSet) {
            super.onInflate(context, attrs)
            val it = context.resources.obtainAttributes(attrs, R.styleable.JourneyNavigator)
            destiny = it.getResourceId(R.styleable.JourneyNavigator_destiny, 0)
            toStart = destiny == 0
            it.recycle()

            if (destiny != 0) {
                if (context.resources.getResourcePackageName(destiny) !=
                    context.resources.getResourcePackageName(graphId)
                ) {
                    val name = context.resources.getResourceName(destiny)
                    throw IllegalStateException(
                        "package ids of destination mismatch from " +
                                "${context.resources.getResourcePackageName(graphId)}." +
                                "\nThe module destinies id \"$name\" must be a destination from " +
                                "${context.resources.getResourceName(graphId)}." +
                                "\nMake sure you are using the same id from " +
                                "${context.resources.getResourceEntryName(graphId)} and not creating a new one."
                    )
                }
            }
        }
    }
}