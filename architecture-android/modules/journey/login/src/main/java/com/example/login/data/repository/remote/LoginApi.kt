package com.example.login.data.repository.remote

import com.example.networking.RequestExecutor

@Suppress("UNUSED_PARAMETER")
class LoginApi(
    private val unsecureRequestExecutor: RequestExecutor,
    private val secureRequestExecutor: RequestExecutor
) {
    suspend fun login(user: String, password: String): String {
        unsecureRequestExecutor.get()
        secureRequestExecutor.post()
        return "João da Silva"
    }
}