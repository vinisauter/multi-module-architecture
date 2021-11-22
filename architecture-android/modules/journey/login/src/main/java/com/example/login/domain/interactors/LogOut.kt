package com.example.login.domain.interactors

import com.example.login.domain.repository.LoginRepository

class LogOut(private val loginRepository: LoginRepository) {
    operator fun invoke(username: String?): Boolean {
        return loginRepository.signOut(username)
    }
}