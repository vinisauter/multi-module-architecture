package com.example.login.presentation.viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import com.core.base.NavigationCommand
import com.core.extensions.Direction
import com.core.extensions.default
import com.core.extensions.onCpu
import com.example.login.presentation.view.ReauthenticationDialogArgs
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class ReauthenticationViewModel(app: Application) : AndroidViewModel(app) {
    private var didFinishDirection: Direction? = null
    fun launch(args: ReauthenticationDialogArgs) = viewModelScope.onCpu {
        didFinishDirection = args.didFinishDirection
    }

    fun onLoginClicked() = viewModelScope.onCpu {
    onActionCompletedSharedFlow.emit(
            didFinishDirection?.let { NavigationCommand.To(it) }.default(NavigationCommand.Back)
        )
    }

    private val onActionCompletedSharedFlow = MutableSharedFlow<NavigationCommand>()
    val onActionCompleted: Flow<NavigationCommand> get() = onActionCompletedSharedFlow

}