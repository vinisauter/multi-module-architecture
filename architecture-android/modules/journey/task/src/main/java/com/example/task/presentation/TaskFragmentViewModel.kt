package com.example.task.presentation

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.navigation.NavDirections
import com.core.extensions.runTask
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class TaskFragmentViewModel(
    private val app: Application,
) : AndroidViewModel(app) {
    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

    fun onExitClicked() = runTask {
        onActionCompletedSharedFlow.emit(
            TaskFragmentDirections.actionExit()
        )
    }

    fun onNotesClicked() = runTask {
        onActionCompletedSharedFlow.emit(
            TaskFragmentDirections.actionNote()
        )
    }
}