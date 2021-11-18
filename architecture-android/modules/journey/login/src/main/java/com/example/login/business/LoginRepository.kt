package com.example.login.business

interface LoginRepository {

    suspend fun login()
    suspend fun recoverPassword()
}