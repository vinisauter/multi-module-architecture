package com.example.login

import androidx.lifecycle.ViewModel

class LoginViewModel(val loginViewUseCaseInterface : LoginViewUseCaseInterface)
    : ViewModel() {

        fun login() {
            loginViewUseCaseInterface.login()
        }
}