package com.example.login.ui.fragments

import com.example.login.domain.interactors.SignIn
import com.example.login.domain.interactors.LogOut
import androidx.lifecycle.ViewModel

class LoginViewModel(private val signIn: SignIn, private val logOut: LogOut) : ViewModel() {
    fun requestSignIn(username: String?, password: String?): Boolean {
        return signIn.invoke(username, password)
    }

    fun requestSignOut(username: String?, password: String?) {
        //logOut.invoke(username, password);
    }
}