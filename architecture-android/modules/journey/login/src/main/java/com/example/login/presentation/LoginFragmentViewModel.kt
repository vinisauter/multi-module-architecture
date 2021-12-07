package com.example.login.presentation

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.navigation.NavDirections
import com.core.extensions.*
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

    private val onStateChangedMutable = MutableLiveData<StateResult>(StateResult.Initial)
    val onStateChanged: LiveData<StateResult>
        get() = onStateChangedMutable

    fun onLoginViewCreated() {
        tagging.send(tracking.loginScreenName)
    }

    fun onLoginClicked() = runTaskResult(onStateChangedMutable) {
        tagging.send(tracking.loginClickAuthEvent)
        useCase.login("user", "password").let {
            when(it) {
                true -> {
                    tagging.send(tracking.loginAuthSucceededEvent)
                    onActionCompletedSharedFlow.emit(
                        LoginFragmentDirections.actionLoginSucceed(com.example.app.R.id.home_navigation)
                    )
                }
                false ->{
                    tagging.send(tracking.loginAuthFailedEvent)
                    onActionCompletedSharedFlow.emit(
                        LoginFragmentDirections.actionLoginFailed()
                    )
                }
            }
        }
    }

    fun onForgotPasswordClicked() = runTaskResult(onStateChangedMutable) {
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