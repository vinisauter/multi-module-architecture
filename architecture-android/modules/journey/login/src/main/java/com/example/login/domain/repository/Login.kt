package com.example.login.domain.repository

interface Login {
    suspend operator fun invoke(user: String, password: String): Boolean
}