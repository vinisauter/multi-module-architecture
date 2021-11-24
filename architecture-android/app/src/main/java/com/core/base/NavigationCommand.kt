package com.core.base

import androidx.navigation.NavDirections

/*
private val onNavigationCommandSharedFlow = MutableSharedFlow<NavigationCommand>()
val onNavigationCommand: Flow<NavigationCommand>
    get() = onNavigationCommandSharedFlow

viewModel.onNavigationCommand.collect { command ->
    val navController = findNavController()
    when (command) {
        is NavigationCommand.To ->
            navController.navigate(command.directions)
        NavigationCommand.Back ->
            navController.popBackStack()
        is NavigationCommand.BackTo ->
            navController.popBackStack(command.destinationId, false)
        NavigationCommand.ToRoot ->
            navController.popBackStack(navController.graph.startDestinationId, false)
    }
}
* */
sealed class NavigationCommand {
    data class To(val directions: NavDirections) : NavigationCommand()
    object Back : NavigationCommand()
    data class BackTo(val destinationId: Int) : NavigationCommand()
    object ToRoot : NavigationCommand()
}