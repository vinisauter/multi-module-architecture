package com.example.login.model.repository

import com.example.login.model.repository.data.request.LoginRequest
import com.example.login.model.repository.data.response.LoginResponse
import kotlinx.coroutines.flow.Flow

interface LoginRepository {
    fun login(login: LoginRequest): Flow<LoginResponse>
}