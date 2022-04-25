package com.example.login.model

class ForgotPassword() {
    suspend operator fun invoke(): Boolean {
        Thread.sleep(3_000)
        return true
    }
}