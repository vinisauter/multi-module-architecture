package com.example.login.model.business

import android.util.Log
import com.example.login.LoginLauncher
import com.example.login.model.LoginUseCase
import com.example.login.model.repository.LoginRepository
import com.example.login.model.repository.data.request.LoginRequest
import com.example.login.model.repository.rest.LoginCall
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

object LoginBusinessModel : LoginUseCase {
    val repository: LoginRepository = LoginCall // by inject

    override fun onLoginButton(cpf: String, password: String): Flow<Boolean> {
        LoginLauncher.analyticTagFor("btLogin")?.let{
            Log.i("TRACKING", it)
        }
        val request = LoginRequest(
            cpf= cpf,
            password= password
        )
        return repository.login(request).map {
            it.isOnBoardingApprovedFinalized && it.isDeviceActive
        }

    }
}