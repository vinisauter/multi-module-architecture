package com.example.login.domain.interactors

interface InteractorLocator {
    fun signIn(): SignIn?
    fun logOut(): LogOut?
}