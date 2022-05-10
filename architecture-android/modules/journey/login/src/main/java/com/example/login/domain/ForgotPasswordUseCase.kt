package com.example.login.domain

class ForgotPasswordUseCase() {
    suspend operator fun invoke(): Boolean {
        Thread.sleep(3_000)
        return true
    }
}