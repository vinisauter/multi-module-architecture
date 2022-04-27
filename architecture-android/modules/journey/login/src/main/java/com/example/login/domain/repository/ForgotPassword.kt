package com.example.login.domain.repository

interface ForgotPassword {
    suspend operator fun invoke(): Boolean
}