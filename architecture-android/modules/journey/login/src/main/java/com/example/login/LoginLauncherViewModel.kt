package com.example.login

import android.app.Application
import android.net.Uri
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavDirections
import com.core.analytics.Tagging
import com.core.extensions.default
import com.core.extensions.onCpu
import com.example.journey.login.tracking.LoginTracking
import com.example.login.business.LoginBusinessModel
import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi
import com.example.structural.StructuralProvider
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class LoginLauncherViewModel(app: Application) : AndroidViewModel(app) {
    private val dependencies = LoginDependencyProvider

    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

    fun launch(deepLink: Uri?, args: LoginLauncherDialogArgs) = viewModelScope.onCpu {
        //Start all the module dependencies
        val tracking: LoginTracking =
            args.loginCustomDependencies?.tracking.default(LoginTracking())

        // TODO: Remover acesso direto ao APP - StructuralProvider
        val tagging: Tagging = StructuralProvider.tagging
        val loginApi = LoginApi(StructuralProvider.networking)
        val loginStorage = LoginStorage(StructuralProvider.storage)
        val loginBusinessModel = LoginBusinessModel(loginApi, loginStorage)

        dependencies.setup(tagging, tracking, loginBusinessModel, loginBusinessModel)
//        dependencies.setup(get(), get(), get(), get())

        Thread.sleep(3_000)
        //TODO: Validate args & DeepLink and Directions
        val reauthenticateDirection = args.loginCustomDependencies?.didFinishDirection
        if (reauthenticateDirection != null) {
            onActionCompletedSharedFlow.emit(
                LoginLauncherDialogDirections.actionReauthentication(reauthenticateDirection)
            )
        } else {
            onActionCompletedSharedFlow.emit(
                LoginLauncherDialogDirections.actionLogin(tracking)
            )
        }
    }
}