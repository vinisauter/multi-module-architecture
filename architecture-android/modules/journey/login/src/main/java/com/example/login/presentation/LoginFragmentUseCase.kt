package com.example.login.presentation

interface LoginFragmentUseCase {
    suspend fun login(user: String, password: String): Boolean
}