package com.example.login.presentation.forgotpassword

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

class ForgotPasswordFragmentViewModel(app: Application) : AndroidViewModel(app) {
    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

    // TODO: LoginDependencyProvider really necessary?
    private val dependencies = LoginDependencyProvider
    private val useCase: ForgotPasswordFragmentUseCase = dependencies.forgotPasswordUseCase
    private val tagging: Tagging = dependencies.tagging
    private val tracking: LoginTracking = dependencies.tracking

    fun onForgotPasswordViewCreated() {
        tagging.sendScreenName(tracking.forgotPasswordScreenName)
    }

    fun onExitClicked() = viewModelScope.onCpu {
        tagging.sendEvent(tracking.forgotPasswordClickExitEvent)
        onActionCompletedSharedFlow.emit(ForgotPasswordFragmentDirections.actionExit())
    }
}