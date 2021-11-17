package com.example.login.presentation

interface LoginFragmentTracking {
    fun onLoginViewCreated()
    fun onLoginClicked()
    fun onLoginSucceed()
    fun onLoginFailed()
    fun onForgotPasswordClicked()
}