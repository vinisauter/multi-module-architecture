package com.example.login.presentation.forgotpassword

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavDirections
import com.core.extensions.onCpu
import com.example.journey.login.tracking.LoginTracking
import com.example.login.domain.ForgotPasswordUseCase
import com.example.tagging.TaggingExecutor
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class ForgotPasswordFragmentViewModel(
    private val app: Application,
    private val useCase: ForgotPasswordUseCase,
    private val tagging: TaggingExecutor,
    private val tracking: LoginTracking,
) : AndroidViewModel(app) {
    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

    fun onForgotPasswordViewCreated() {
        tagging.send(tracking.forgotPasswordScreenName)
    }

    fun onExitClicked() = viewModelScope.onCpu {
        tagging.send(tracking.forgotPasswordClickExitEvent)
        onActionCompletedSharedFlow.emit(ForgotPasswordFragmentDirections.actionExit())
    }
}