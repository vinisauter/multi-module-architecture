package com.example.login.business

import com.example.login.presentation.LoginUseCase

class LoginBusinessModel(val mRepository: LoginRepositoryImpl): LoginUseCase {

    override suspend fun login(email: String?, password: String?) {
        mRepository.login()
    }
}