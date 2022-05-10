package com.example.login

import android.app.Application
import com.core.base.BaseViewModelFactory
import com.example.journey.login.tracking.LoginTracking
import com.example.login.domain.ForgotPasswordUseCase
import com.example.login.domain.LoginUseCase
import com.example.login.repository.local.LoginStorage
import com.example.login.repository.remote.LoginApi
import com.example.structural.StructuralProvider
import com.example.tagging.TaggingExecutor

class LoginDependenciesProvider(
    private val application: Application,
    private val tracking: LoginTracking,
) : BaseViewModelFactory.Provider(block = {
    declare<TaggingExecutor> { StructuralProvider.defaultTaggingExecutor }
    declare<LoginTracking> { tracking }
    declare<LoginUseCase> {
        LoginUseCase(
            LoginApi(
                StructuralProvider.unsecureRequestExecutor,
                StructuralProvider.secureRequestExecutor
            ),
            LoginStorage(StructuralProvider.defaultStorageExecutor)
        )
    }
    declare<ForgotPasswordUseCase> { ForgotPasswordUseCase() }
})