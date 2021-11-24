package com.example.login

import android.util.Log

class LoginRepository : LoginRepositoryInterface {
    override fun login() {
        Log.e("LoginRepository: ", "onLoginClick")
    }
}