package com.example.login.domain.usecase

import com.example.login.domain.repository.ForgotPassword

interface ForgotPasswordUseCase {
    suspend fun execute(): Boolean

    class Impl(val forgotPassword: ForgotPassword) : ForgotPasswordUseCase {
        override suspend fun execute() = true
    }
}