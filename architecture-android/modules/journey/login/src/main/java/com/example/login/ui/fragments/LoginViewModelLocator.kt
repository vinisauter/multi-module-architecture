package com.example.login.ui.fragments

import androidx.fragment.app.Fragment

interface LoginViewModelLocator {
    fun loginViewModel(fragment: Fragment?): LoginViewModel?
}