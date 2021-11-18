package com.example.login.presentation

interface LoginUseCase {
    
    suspend fun login(email: String?, password: String?)

}