package com.example.login.domain

import com.example.login.repository.local.LoginStorage
import com.example.login.repository.remote.LoginApi

class LoginUseCase(
    private val api: LoginApi,
    private val storage: LoginStorage
) {
    suspend operator fun invoke(user: String, password: String): Boolean {
        val userName = api.login(user, password)
        storage.save(userName)
        Thread.sleep(3_000)
        return true
    }
}