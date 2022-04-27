package com.example.login.data.repository

import com.example.login.domain.repository.ForgotPassword

class ForgotPasswordImpl() : ForgotPassword {
    override suspend operator fun invoke(): Boolean {
        Thread.sleep(3_000)
        return true
    }
}