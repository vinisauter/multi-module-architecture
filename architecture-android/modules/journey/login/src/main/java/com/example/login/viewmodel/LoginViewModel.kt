package com.example.login.viewmodel

import android.text.Editable
import androidx.lifecycle.ViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

class LoginViewModel(): ViewModel() {

    private val _tvUsername = MutableStateFlow("")
    val tvUsername: StateFlow<String> = _tvUsername

    private val _tfPassword = MutableStateFlow("")
    val tfPassword: StateFlow<String> = _tfPassword

    private val _btLogin = MutableStateFlow(false)
    val btLogin: StateFlow<Boolean> = _btLogin

   fun setPassword(password: Editable){
       _tfPassword.value = password.toString()
   }

    init {
        _tvUsername.value = "Usuário: Teste"
    }

    fun onBtLoginClick(){
        _btLogin.value = true
    }


}