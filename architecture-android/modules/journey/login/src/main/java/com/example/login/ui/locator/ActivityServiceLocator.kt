package com.example.login.ui.locator

import androidx.fragment.app.Fragment
import com.example.login.data.locator.DataServiceLocator.Companion.instance
import com.example.login.ui.fragments.LoginViewModelLocator
import com.example.login.domain.interactors.InteractorLocator
import com.example.login.ui.fragments.LoginViewModel
import com.example.login.domain.interactors.SignIn
import com.example.login.domain.interactors.LogOut
import com.example.login.domain.repository.RepositoryLocator

class ActivityServiceLocator : LoginViewModelLocator, InteractorLocator {
    private var loginViewModel: LoginViewModel? = null
    private var signIn: SignIn? = null
    private var logOut: LogOut? = null
    override fun signIn(): SignIn? {
        if (signIn == null) {
            val repositoryLocator: RepositoryLocator = instance
            signIn = SignIn(repositoryLocator.loginRepository()!!)
        }
        return signIn
    }

    override fun logOut(): LogOut? {
        if (logOut == null) {
            val repositoryLocator: RepositoryLocator = instance
            logOut = LogOut(repositoryLocator.loginRepository()!!)
        }
        return logOut
    }

    override fun loginViewModel(fragment: Fragment?): LoginViewModel? {
        if (loginViewModel == null) {
            loginViewModel = LoginViewModel(signIn()!!, logOut()!!)
        }
        return loginViewModel
    }
}