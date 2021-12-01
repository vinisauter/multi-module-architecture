package com.example.profile.presentation

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.navigation.NavDirections
import com.core.extensions.runTask
import com.example.journey.login.tracking.LoginTracking
import com.example.tagging.Tagging
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class ProfileFragmentViewModel(
    private val app: Application,
) : AndroidViewModel(app) {
    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

    fun onExitClicked() = runTask {
        onActionCompletedSharedFlow.emit(
            ProfileFragmentDirections.actionExit(
                com.example.app.R.id.splash
            )
        )
    }

    fun onHomeClicked() = runTask {
        onActionCompletedSharedFlow.emit(
            ProfileFragmentDirections.actionLaunchHome()
        )
    }

    fun onLoginClicked() = runTask {
        val tracking = LoginTracking(
            //LoginFragment
            loginScreenName = Tagging.ScreenName("profile_login"),
            loginClickAuthEvent = Tagging.Event("profile_login", "click", "auth"),
            loginAuthSucceededEvent = Tagging.Event("profile_login", "auth", "succeeded"),
            loginAuthFailedEvent = Tagging.Event("profile_login", "auth", "failed"),
            loginClickForgotPasswordEvent = Tagging.Event(
                "profile_login",
                "click",
                "forgot_password"
            ),
            //ForgotPasswordFragment
            forgotPasswordScreenName = Tagging.ScreenName("profile_forgot_password"),
            forgotPasswordClickExitEvent = Tagging.Event(
                "profile_forgot_password",
                "click",
                "exit"
            ),
        )
        onActionCompletedSharedFlow.emit(
            ProfileFragmentDirections.actionLogin(tracking = tracking)
        )
    }

    fun onReauthenticateClicked() = runTask {
        onActionCompletedSharedFlow.emit(
            // TODO: redirect result
            //  Start(Reauthenticate) + didFinishDirection(this)
            //  https://medium.com/google-developer-experts/using-navigation-architecture-component-in-a-large-banking-app-ac84936a42c2
            ProfileFragmentDirections.actionReauthenticate()
        )
    }
}