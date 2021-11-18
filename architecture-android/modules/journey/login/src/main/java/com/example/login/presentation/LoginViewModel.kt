package com.example.login.presentation

import com.example.core.NextBaseViewModel
import com.example.login.business.LoginBusinessModel
import kotlinx.coroutines.coroutineScope

class LoginViewModel(val mBusinessModel: LoginBusinessModel) :
    NextBaseViewModel() {

    suspend fun login(email: String?, password: String?) {
        coroutineScope {
            mBusinessModel.login(email, password)
        }
    }
}