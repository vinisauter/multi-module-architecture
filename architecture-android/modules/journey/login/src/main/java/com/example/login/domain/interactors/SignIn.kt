package com.example.login.domain.interactors

import com.example.login.domain.repository.LoginRepository

class SignIn(private val loginRepository: LoginRepository) {
    operator fun invoke(username: String?, password: String?): Boolean {
        return loginRepository.signIn(username, password)
    }
}