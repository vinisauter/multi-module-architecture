package com.example.login.business

import com.example.login.business.data.LoginLocalDataSource
import com.example.login.business.data.LoginRemoteDateSource

class LoginRepositoryImpl(
    private val mLocalDataSource: LoginLocalDataSource,
    private val mRemoteDateSource: LoginRemoteDateSource
) : LoginRepository {

    override suspend fun login() {
        mLocalDataSource.saveUser()
        print(mRemoteDateSource.login())
    }

    override suspend fun recoverPassword() {
        //TODO Call recover password
    }

}