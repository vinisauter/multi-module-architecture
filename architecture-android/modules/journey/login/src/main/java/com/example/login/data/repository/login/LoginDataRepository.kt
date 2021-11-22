package com.example.login.data.repository.login


import com.example.login.domain.repository.LoginRepository

class LoginDataRepository(private val loginDataSource: LoginDataSource) : LoginRepository {
    override fun signUp(email: String?, password: String?): Boolean {
        return true
    }

    override fun signIn(email: String?, password: String?): Boolean {
        return loginDataSource.signIn(email, password)
    }

    override fun checkAlreadyAuthenticated(): Boolean {
        return false
    }

    override fun signOut(email: String?): Boolean {
        return false
    }
}