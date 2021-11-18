package com.example.login.viewmodel

import android.text.Editable
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.login.model.LoginUseCase
import com.example.login.model.business.LoginBusinessModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class LoginViewModel(): ViewModel() {
    val business: LoginUseCase = LoginBusinessModel // by inject

    private val _tfCpf = MutableStateFlow("")
    val tfCpf: StateFlow<String> = _tfCpf

    private val _tfPassword = MutableStateFlow("")
    val tfPassword: StateFlow<String> = _tfPassword

    private val _btLogin = MutableStateFlow(false)
    val btLogin: StateFlow<Boolean> = _btLogin

   fun setCpf(cpf: Editable){
       _tfCpf.value = cpf.toString()
   }

   fun setPassword(password: Editable){
       _tfPassword.value = password.toString()
   }

    fun onBtLoginClick(){
        val cpf = tfCpf.value
        val password = tfPassword.value
        viewModelScope.launch {
            business.onLoginButton(cpf = cpf, password = password).collect { success ->
                if (success) {
                    _btLogin.value = true
                }
            }
        }
    }


}