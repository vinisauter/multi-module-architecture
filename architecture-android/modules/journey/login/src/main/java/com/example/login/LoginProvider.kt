package com.example.login

import android.injection.Module
import com.core.base.BaseProvider
import com.example.journey.login.tracking.LoginTracking
import com.example.login.core.ForgotPassword
import com.example.login.core.Login
import com.example.login.core.repository.local.LoginStorage
import com.example.login.core.repository.remote.LoginApi
import com.example.login.presentation.LoginFragmentUseCases
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

    //Use Cases
    private val login = Login(api, storage)
    private val loginFragmentUseCases = LoginFragmentUseCases(login)
    private val forgotPassword = ForgotPassword()


    override fun Module.dependencies() {
        shared<LoginTracking> { tracking }
        shared<Login> { login }
        shared<ForgotPassword> { forgotPassword }
        shared<LoginFragmentUseCases> { loginFragmentUseCases }
    }
}