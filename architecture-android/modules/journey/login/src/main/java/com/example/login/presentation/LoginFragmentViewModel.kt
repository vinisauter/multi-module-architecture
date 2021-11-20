package com.example.login.presentation

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavDirections
import com.core.analytics.Tagging
import com.core.extensions.onCpu
import com.example.journey.login.tracking.LoginTracking
import com.example.login.LoginDependencyProvider
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
    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

    // TODO: LoginDependencyProvider really necessary?
    private val dependencies = LoginDependencyProvider
    private val useCase: LoginFragmentUseCase = dependencies.loginUseCase
    private val tagging: Tagging = dependencies.tagging
    private val tracking: LoginTracking = dependencies.tracking

    fun onLoginViewCreated() {
        tagging.sendScreenName(tracking.loginScreenName)
    }

    fun onLoginClicked() = viewModelScope.onCpu {
        tagging.sendEvent(tracking.loginClickAuthEvent)
        try {
            // TODO: loader manager
            useCase.login("user", "password")

            onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginSucceed())
            tagging.sendEvent(tracking.loginAuthSucceededEvent)
        } catch (t: Throwable) {
            onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginFailed())
            tagging.sendEvent(tracking.loginAuthFailedEvent)
        }
    }

    fun onForgotPasswordClicked() = viewModelScope.onCpu {
        tagging.sendEvent(tracking.loginClickForgotPasswordEvent)
        onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionForgotPassword())
    }
}