package com.example.login.presentation

import android.app.Application
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.SavedStateHandle
import androidx.navigation.NavDirections
import com.core.base.BaseViewModel
import com.core.extensions.State
import com.core.extensions.default
import com.core.extensions.runTask
import com.example.app.AppNavigationGraphDirections
import com.example.journey.login.tracking.LoginTracking
import com.example.tagging.TaggingExecutor
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class LoginFragmentViewModel(
    private val app: Application,
    private val savedStateHandle: SavedStateHandle,
    private val tagging: TaggingExecutor,
    private val useCase: LoginFragmentUseCase,
    private val tracking: LoginTracking
) : BaseViewModel(app, savedStateHandle) {
    //https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines.flow/-flow/
//   TODO use NavigationCommand?
//    private val onNavigationCommandSharedFlow = MutableSharedFlow<NavigationCommand>()
    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

    private val onStateChangedMutable = MutableLiveData<State>(State.Idle)
    val onStateChanged: LiveData<State>
        get() = onStateChangedMutable

    fun onLoginViewCreated() {
        tagging.send(tracking.loginScreenName)
    }

    fun onLoginClicked() = runTask(onStateChangedMutable) {
        tagging.send(tracking.loginClickAuthEvent)
        try {
            when (useCase.login("user", "password")) {
                true -> {
                    onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginSucceed())
                    tagging.send(tracking.loginAuthSucceededEvent)
                }
                false -> {
                    onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginFailed())
                    tagging.send(tracking.loginAuthFailedEvent)
                }
            }
        } catch (t: Throwable) {
            onActionCompletedSharedFlow.emit(LoginFragmentDirections.actionLoginFailed())
            tagging.send(tracking.loginAuthFailedEvent)
        }
    }

    fun onForgotPasswordClicked() = runTask(onStateChangedMutable) {
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