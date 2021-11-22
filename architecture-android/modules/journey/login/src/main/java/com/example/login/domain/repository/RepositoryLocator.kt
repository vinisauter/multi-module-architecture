package com.example.login.domain.repository

interface RepositoryLocator {
    fun loginRepository(): LoginRepository?
    fun userRepository(): UserRepository?
    fun loggedUserRepository(): AuthenticatedUserRepository?
}