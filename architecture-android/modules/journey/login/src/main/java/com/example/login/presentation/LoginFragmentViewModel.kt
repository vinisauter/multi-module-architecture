package com.example.login.presentation

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavDirections
import com.core.analytics.Tagging
import com.core.extensions.onCpu
import com.example.journey.login.tracking.LoginTracking
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class LoginFragmentViewModel(
    private val app: Application,
    private val tagging: Tagging,
    private val useCase: LoginFragmentUseCase,
    private val tracking: LoginTracking
) : AndroidViewModel(app) {
    //https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines.flow/-flow/
//   TODO use NavigationCommand?
//    private val onNavigationCommandSharedFlow = MutableSharedFlow<NavigationCommand>()
    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

    fun onLoginViewCreated() {
        tagging.sendScreenName(tracking.loginScreenName)
    }

    fun onLoginClicked() = viewModelScope.onCpu {
        tagging.sendEvent(tracking.loginClickAuthEvent)
        try {
            // TODO: loader
            useCase.login("user", "password")
//            onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginSucceed())
            tagging.sendEvent(tracking.loginAuthSucceededEvent)
        } catch (t: Throwable) {
//            onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginFailed())
            tagging.sendEvent(tracking.loginAuthFailedEvent)
        }
    }

    fun onForgotPasswordClicked() = viewModelScope.onCpu {
        tagging.sendEvent(tracking.loginClickForgotPasswordEvent)
        try {
            // TODO: loader
            useCase.login("user", "password")
//            onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginSucceed())
            tagging.sendEvent(tracking.loginForgotPasswordSucceededEvent)
        } catch (t: Throwable) {
//            onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginFailed())
            tagging.sendEvent(tracking.loginForgotPasswordFailedEvent)
        }
    }
}