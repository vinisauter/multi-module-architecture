package com.example.login.business

import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi
import com.example.login.presentation.LoginFragmentUseCase
import com.example.login.presentation.forgotpassword.ForgotPasswordFragmentUseCase

class LoginBusinessModel(
    private val api: LoginApi,
    private val storage: LoginStorage
) : LoginFragmentUseCase, ForgotPasswordFragmentUseCase {
    override suspend fun login(user: String, password: String): Boolean {
        val userName = api.login(user, password)
        storage.save(userName)
        return true
    }
}
