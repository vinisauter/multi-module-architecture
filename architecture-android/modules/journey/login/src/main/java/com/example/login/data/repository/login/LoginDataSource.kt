package com.example.login.data.repository.login;

 interface LoginDataSource {
    fun signUp(email: String?, password: String?): Boolean
    fun signIn(email: String?, password: String?): Boolean
    fun checkAlreadyAuthenticated(): Boolean
    fun signOut(email: String?): Boolean
}
