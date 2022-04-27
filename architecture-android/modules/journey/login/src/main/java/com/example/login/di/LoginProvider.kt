package com.example.login.di

import android.injection.Module
import com.core.base.BaseProvider
import com.example.journey.login.tracking.LoginTracking
import com.example.login.data.repository.LoginImpl
import com.example.login.data.repository.local.LoginStorage
import com.example.login.data.repository.remote.LoginApi
import com.example.login.domain.usecase.LoginUseCase
import com.example.login.data.repository.ForgotPasswordImpl
import com.example.login.domain.repository.ForgotPassword
import com.example.login.domain.repository.Login
import com.example.networking.RequestExecutor
import com.example.storage.StorageExecutor
import com.example.structural.StructuralProvider

class LoginProvider(private val tracking: LoginTracking) : BaseProvider {
    private val secureRequestExecutor: RequestExecutor =
        StructuralProvider.secureRequestExecutor//get(qualifier = "secure")
    private val unsecureRequestExecutor: RequestExecutor =
        StructuralProvider.unsecureRequestExecutor//get(qualifier = "unsecure")
    private val storageExecutor: StorageExecutor =
        StructuralProvider.defaultStorageExecutor//get()

    private val storage = LoginStorage(storageExecutor)
    private val api = LoginApi(unsecureRequestExecutor, secureRequestExecutor)

    //Repository
    private val login = LoginImpl(api, storage)
    private val forgotPassword = ForgotPasswordImpl()

    //Usecase
    private val loginFragmentUseCase = LoginUseCase(login)


    override fun Module.dependencies() {
        shared<LoginTracking> { tracking }
        shared<LoginUseCase> { loginFragmentUseCase }
        shared<Login> { login }
        shared<ForgotPassword> { forgotPassword }
    }
}