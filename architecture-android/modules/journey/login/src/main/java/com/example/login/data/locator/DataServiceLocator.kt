package com.example.login.data.locator

import com.example.login.domain.repository.RepositoryLocator
import com.example.login.domain.repository.LoginRepository
import com.example.login.data.repository.login.LoginDataSource
import com.example.login.data.repository.login.LoginDataRepository
import com.example.login.data.repository.login.FakeLoginDataSource
import com.example.login.domain.repository.UserRepository
import com.example.login.domain.repository.AuthenticatedUserRepository

class DataServiceLocator : RepositoryLocator {
    private var loginRepository: LoginRepository? = null
    private var loginDataSource: LoginDataSource? = null
    override fun loginRepository(): LoginRepository? {
        if (loginRepository == null) {
            loginRepository = LoginDataRepository(loginDataSource())
        }
        return loginRepository
    }

    private fun loginDataSource(): LoginDataSource {
        if (loginDataSource == null) {
            loginDataSource = FakeLoginDataSource()
        }
        return loginDataSource as LoginDataSource
    }

    override fun userRepository(): UserRepository? {
        return null
    }

    override fun loggedUserRepository(): AuthenticatedUserRepository? {
        return null
    }

    private object Instance {
        val instance = DataServiceLocator()
    }

    companion object {
        @JvmStatic
        val instance: DataServiceLocator
            get() = Instance.instance
    }
}