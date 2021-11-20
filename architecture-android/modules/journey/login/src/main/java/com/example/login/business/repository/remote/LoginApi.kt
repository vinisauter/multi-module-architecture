package com.example.login.business.repository.remote

import com.example.networking.RequestExecutor

@Suppress("UNUSED_PARAMETER")
class LoginApi(private val executor: RequestExecutor) {
    suspend fun login(user: String, password: String): String {
        executor.get()
        return "João da Silva"
    }
}