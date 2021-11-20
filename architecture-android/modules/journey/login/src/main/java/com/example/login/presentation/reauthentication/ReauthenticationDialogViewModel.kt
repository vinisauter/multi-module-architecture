package com.example.login.presentation.reauthentication

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavDirections
import com.core.extensions.Direction
import com.core.extensions.onCpu
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class ReauthenticationDialogViewModel(app: Application) : AndroidViewModel(app) {
    lateinit var didFinishDirection: Direction
    fun launch(args: ReauthenticationDialogArgs) = viewModelScope.onCpu {
        didFinishDirection = args.didFinishDirection
    }

    fun onLoginClicked() = viewModelScope.onCpu {
        onActionCompletedSharedFlow.emit(didFinishDirection)
    }

    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

}