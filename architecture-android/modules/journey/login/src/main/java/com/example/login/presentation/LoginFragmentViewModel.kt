package com.example.login.presentation

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavDirections
import com.core.extensions.onCpu
import com.example.login.LoginLauncher
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class LoginFragmentViewModel(app: Application) : AndroidViewModel(app) {
    //https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines.flow/-flow/
    //There are the following basic ways to create a flow:
    //flowOf(...) functions to create a flow from a fixed set of values.
    //asFlow() extension functions on various types to convert them into flows.
    //flow { ... } builder function to construct arbitrary flows from sequential calls to emit function.
    //channelFlow { ... } builder function to construct arbitrary flows from potentially concurrent calls to the send function.
    //MutableStateFlow and MutableSharedFlow define the corresponding constructor functions to create a hot flow that can be directly updated.
    private val onActionCompletedFlow = MutableSharedFlow<NavDirections>()

    private val useCase: LoginFragmentUseCase = LoginLauncher.loginFragmentUseCase
    private val tracking: LoginFragmentTracking = LoginLauncher.loginFragmentTracking

    fun onLoginViewCreated() {
        tracking.onLoginViewCreated()
    }

    fun onLoginClicked() = viewModelScope.onCpu {
        tracking.onLoginClicked()
        try {
            useCase.login("user", "password")

            onActionCompletedFlow.emit(LoginFragmentDirections.actionLoginSucceed())
            tracking.onLoginSucceed()
        } catch (t: Throwable) {
            onActionCompletedFlow.emit(LoginFragmentDirections.actionLoginFailed())
            tracking.onLoginFailed()
        }
    }

    fun onForgotPasswordClicked() = viewModelScope.onCpu {
        tracking.onForgotPasswordClicked()
        onActionCompletedFlow.emit(LoginFragmentDirections.actionForgotPassword())
    }

    fun onActionCompleted(): Flow<NavDirections> {
        return onActionCompletedFlow
    }
}