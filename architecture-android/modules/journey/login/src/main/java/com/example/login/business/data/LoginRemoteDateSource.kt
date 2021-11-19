package com.example.login.business.data

import com.example.networking.RequestExecutor

class LoginRemoteDateSource(
    private val mNetwork: RequestExecutor
) {

    suspend fun login() {
        mNetwork.get()
    }

}