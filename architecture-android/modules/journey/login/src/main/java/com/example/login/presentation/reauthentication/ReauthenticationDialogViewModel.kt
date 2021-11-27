package com.example.login.presentation.reauthentication

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import com.core.base.NavigationCommand
import com.core.extensions.Direction
import com.core.extensions.default
import com.core.extensions.onCpu
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class ReauthenticationDialogViewModel(app: Application) : AndroidViewModel(app) {
    private var didFinishDirection: Direction? = null
    fun launch(args: ReauthenticationDialogArgs) = viewModelScope.onCpu {
        didFinishDirection = args.didFinishDirection
    }

    fun onLoginClicked() = viewModelScope.onCpu {
//        AppNavigationGraphDirections.
        onActionCompletedSharedFlow.emit(
            didFinishDirection?.let { NavigationCommand.To(it) }.default(NavigationCommand.ToRoot)
        )
    }

    private val onActionCompletedSharedFlow = MutableSharedFlow<NavigationCommand>()
    val onActionCompleted: Flow<NavigationCommand> get() = onActionCompletedSharedFlow

}