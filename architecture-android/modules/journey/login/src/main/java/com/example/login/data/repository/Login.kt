package com.example.login.data.repository

import com.example.login.data.repository.local.LoginStorage
import com.example.login.data.repository.remote.LoginApi


class Login(
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