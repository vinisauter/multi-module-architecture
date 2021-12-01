package com.example.home.presentation

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.navigation.NavDirections
import com.core.extensions.runTask
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class HomeFragmentViewModel(
    private val app: Application,
) : AndroidViewModel(app) {
    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

    fun onProfileClicked() = runTask {
        onActionCompletedSharedFlow.emit(
            HomeFragmentDirections.actionAppDestination(
                com.example.app.R.id.profile_navigation
            )
        )
    }

    fun onExitClicked() = runTask {
        onActionCompletedSharedFlow.emit(
            HomeFragmentDirections.actionAppDestination(
                com.example.app.R.id.splash
            )
        )
    }
}