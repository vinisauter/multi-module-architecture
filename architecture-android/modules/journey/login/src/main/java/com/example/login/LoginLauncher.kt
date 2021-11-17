package com.example.login

import com.example.login.business.ForgotPasswordTrackingImpl
import com.example.login.business.LoginBusinessModel
import com.example.login.business.LoginFragmentTrackingImpl
import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi
import com.example.login.presentation.LoginFragmentTracking
import com.example.login.presentation.LoginFragmentUseCase
import com.example.login.presentation.forgotpassword.ForgotPasswordFragmentTracking
import com.example.login.presentation.forgotpassword.ForgotPasswordFragmentUseCase
import com.example.structural.StructuralProvider

object LoginLauncher {
    private val loginApi = LoginApi(StructuralProvider.networking)
    private val loginStorage = LoginStorage(StructuralProvider.storage)
    private val loginBusinessModel: LoginBusinessModel = LoginBusinessModel(loginApi, loginStorage)
    val loginFragmentUseCase: LoginFragmentUseCase = loginBusinessModel
    val loginFragmentTracking: LoginFragmentTracking = LoginFragmentTrackingImpl()

    val forgotPasswordTracking: ForgotPasswordFragmentTracking = ForgotPasswordTrackingImpl()
    val forgotPasswordUseCase: ForgotPasswordFragmentUseCase = loginBusinessModel
}