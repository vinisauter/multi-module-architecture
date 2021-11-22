package com.example.login.domain.repository

interface LoginRepository {
    fun signUp(email: String?, password: String?): Boolean
    fun signIn(email: String?, password: String?): Boolean
    fun checkAlreadyAuthenticated(): Boolean
    fun signOut(email: String?): Boolean
}