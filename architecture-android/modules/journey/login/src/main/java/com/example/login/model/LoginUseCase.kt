package com.example.login.model

import kotlinx.coroutines.flow.Flow

interface LoginUseCase {
    fun onLoginButton(cpf: String, password: String): Flow<Boolean>
}