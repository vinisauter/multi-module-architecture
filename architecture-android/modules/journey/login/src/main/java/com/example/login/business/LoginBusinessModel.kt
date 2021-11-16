package com.example.login.business

import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi
import com.example.login.presentation.LoginFragmentUseCase
import com.example.structural.StructuralProvider

class LoginBusinessModel : LoginFragmentUseCase {
    private val api = LoginApi(StructuralProvider.networking)
    private val storage = LoginStorage(StructuralProvider.storage)

    override suspend fun login(user: String, password: String): Boolean {
        val userName = api.login(user, password)
        storage.save(userName)
        return true
    }
}
