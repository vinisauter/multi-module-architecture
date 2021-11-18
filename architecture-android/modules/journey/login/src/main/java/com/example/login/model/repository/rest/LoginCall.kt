package com.example.login.model.repository.rest

import com.example.login.model.repository.LoginRepository
import com.example.login.model.repository.data.request.LoginRequest
import com.example.login.model.repository.data.response.LoginResponse
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.*

object LoginCall : LoginRepository {

    override fun login(login: LoginRequest): Flow<LoginResponse> {
        return flow {
            delay(1500L)
            val response = LoginResponse(
                onboardingStatus = 5,
                deviceRegistrationStatus = 1,
                name = "Fulano Teste",
                nickname = "Teste",
                agency = "1234",
                accountNumber = "1234",
                accountDigit = "5",
                branch = "Next"
            )
            emit(response)
        }
    }

}