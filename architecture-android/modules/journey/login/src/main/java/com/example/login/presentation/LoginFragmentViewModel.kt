package com.example.login.presentation

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavDirections
import com.core.extensions.default
import com.core.extensions.onCpu
import com.example.app.AppNavigationGraphDirections
import com.example.journey.login.tracking.LoginTracking
import com.example.tagging.TaggingExecutor
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class LoginFragmentViewModel(
    private val app: Application,
    private val tagging: TaggingExecutor,
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
        tagging.send(tracking.loginScreenName)
    }

    fun onLoginClicked() = viewModelScope.onCpu {
        tagging.send(tracking.loginClickAuthEvent)
        try {
            // TODO: loader
            useCase.login("user", "password")
            onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginSucceed())
            tagging.send(tracking.loginAuthSucceededEvent)
        } catch (t: Throwable) {
            onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginFailed())
            tagging.send(tracking.loginAuthFailedEvent)
        }
    }

    fun onForgotPasswordClicked() = viewModelScope.onCpu {
        tagging.send(tracking.loginClickForgotPasswordEvent)
        try {
            onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionForgotPassword())
            tagging.send(tracking.loginForgotPasswordSucceededEvent)
        } catch (t: Throwable) {
            onActionCompletedSharedFlow.emit(
                AppNavigationGraphDirections.actionShowError(
                    t.message.default("ERROR")
                )
            )
            tagging.send(tracking.loginForgotPasswordFailedEvent)
        }
    }
}