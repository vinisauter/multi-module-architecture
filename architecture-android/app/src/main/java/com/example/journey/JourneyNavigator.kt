package com.example.journey

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.AttributeSet
import androidx.navigation.*
import androidx.navigation.NavGraph.Companion.findStartDestination
import com.example.app.R

/**
 * Navigator for `journey`.
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
    private val createdDestinations = mutableListOf<ModuleDestination>()
    override fun createDestination(): ModuleDestination = ModuleDestination(this, graphId).also {
        createdDestinations.add(it)
    }

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
        val destination: NavDestination = resolveDestination(module)
        if (destination is ActivityNavigator.Destination) {
            destination.intent?.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP)
        }
        val navigator: Navigator<NavDestination> = navigatorProvider[destination.navigatorName]
        val newGraphEntry = state.createBackStackEntry(destination, entry.arguments)
        navigator.navigate(listOf(newGraphEntry), navOptions, navigatorExtras)
    }

    private fun resolveDestination(
        module: ModuleDestination
    ): NavDestination {
        val destinationId = module.destiny
        val outerNav = module.parent ?: throw IllegalStateException(
            "The module destination with id ${module.displayName} " +
                    "does not have a parent. Make sure it is attached to a NavGraph."
        )
        var destination: NavDestination? = destinationId.let { outerNav.findNode(it) }
        if (destination == null) {
            val includedNav = navInflater.inflate(graphId)
            includedNav.id = module.id
            if (module.toStart)
                destination = includedNav.findStartDestination()
            val iterator = includedNav.iterator()
            while (iterator.hasNext()) {
                val nextDestination = iterator.next()
                iterator.remove()
                outerNav.addDestination(nextDestination)
                if (destinationId == nextDestination.id) {
                    destination = nextDestination
                }
            }
            if (destination == null) throw IllegalStateException(
                "The module destination with id ${module.displayName} does not have a matching " +
                        "destiny (${context.resources.getResourceName(module.destiny)}).\n" +
                        "Make sure it it exists on ${context.resources.getResourceEntryName(graphId)}."
            )
        }
        // Avoid calling replaceWithIncludedNav() on the same destination more than once
        createdDestinations.remove(destination)
        return destination
    }

    override fun onSaveState(): Bundle? {
        // Return a non-null Bundle to get a callback to onRestoreState
        return Bundle.EMPTY
    }

    override fun onRestoreState(savedState: Bundle) {
        super.onRestoreState(savedState)
        // replaceWithIncludedNav() can add more elements while we're iterating
        // through the list so we need to keep iterating until there's no more
        // unexpanded graphs
        while (createdDestinations.isNotEmpty()) {
            // Iterate through a copy to prevent ConcurrentModificationExceptions
            val iterator = ArrayList(createdDestinations).iterator()
            // And clear the original list so that the list only contains
            // newly inflated destinations from the replaceWithIncludedNav() calls
            // the next time our loop completes
            createdDestinations.clear()
            while (iterator.hasNext()) {
                val dynamicNavGraph = iterator.next()
                resolveDestination(dynamicNavGraph)
            }
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