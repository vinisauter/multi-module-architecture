package com.example.login.domain.usecase

import com.example.login.domain.repository.Login

interface LoginUseCase {
    suspend fun execute(user: String, password: String): Boolean

    class Impl(val login: Login) : LoginUseCase {
        override suspend fun execute(user: String, password: String) = login(user, password)
    }
}