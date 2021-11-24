package com.example.login

class LoginBusinessModel(val repositoryInterface: LoginRepositoryInterface) : LoginViewUseCaseInterface {

    override fun login() {
        repositoryInterface.login()
    }
}