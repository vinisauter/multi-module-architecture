package com.example.login

import android.app.Application
import com.core.base.BaseViewModelFactory
import com.example.journey.login.tracking.LoginTracking
import com.example.login.core.ForgotPassword
import com.example.login.core.Login
import com.example.login.core.repository.local.LoginStorage
import com.example.login.core.repository.remote.LoginApi
import com.example.login.presentation.LoginFragmentUseCases
import com.example.login.presentation.forgotpassword.ForgotPasswordFragmentUseCase
import com.example.structural.StructuralProvider
import com.example.tagging.TaggingExecutor

class LoginDependenciesProvider(
    private val application: Application,
    private val tracking: LoginTracking,
) : BaseViewModelFactory.Provider(block = {
    declare<TaggingExecutor> { StructuralProvider.defaultTaggingExecutor }
    declare<LoginTracking> { tracking }
    declare<LoginFragmentUseCases> {
        LoginFragmentUseCases(
            Login(
                LoginApi(
                    StructuralProvider.unsecureRequestExecutor,
                    StructuralProvider.secureRequestExecutor
                ),
                LoginStorage(StructuralProvider.defaultStorageExecutor)
            )
        )
    }
    declare<ForgotPasswordFragmentUseCase> { ForgotPasswordFragmentUseCase(ForgotPassword()) }
})