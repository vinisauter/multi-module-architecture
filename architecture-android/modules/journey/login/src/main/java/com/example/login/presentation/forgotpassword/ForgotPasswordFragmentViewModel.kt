package com.example.login.presentation.forgotpassword

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavDirections
import com.core.extensions.onCpu
import com.example.login.LoginLauncher
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow

class ForgotPasswordFragmentViewModel(app: Application) : AndroidViewModel(app) {
    private val onActionCompletedLiveData = MutableSharedFlow<NavDirections>()

    private val useCase: ForgotPasswordFragmentUseCase = LoginLauncher.forgotPasswordUseCase
    private val tracking: ForgotPasswordFragmentTracking = LoginLauncher.forgotPasswordTracking

    fun onForgotPasswordViewCreated() {
        tracking.onForgotPasswordViewCreated()
    }

    fun onExitClicked() = viewModelScope.onCpu {
        tracking.onExitClicked()
        onActionCompletedLiveData.emit(ForgotPasswordFragmentDirections.actionExit())
    }

    fun onActionCompleted(): SharedFlow<NavDirections> {
        return onActionCompletedLiveData
    }
}