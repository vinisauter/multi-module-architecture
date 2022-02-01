package com.example.login.business

import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi
import com.example.networking.RequestExecutor
import com.example.storage.StorageExecutor
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.runBlocking
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4

@RunWith(JUnit4::class)
internal class LoginBusinessModelTest() {

    private val unsecureExecutorMockk: RequestExecutor = mockk()

    //    private val secureExecutorMockk: RequestExecutor = mockk()
    private val storageExecutorMockk: StorageExecutor = mockk()

    private val loginApi: LoginApi = LoginApi(unsecureExecutorMockk, unsecureExecutorMockk)
    private val loginStorage: LoginStorage = LoginStorage(storageExecutorMockk)

    private val loginBusinessModel: LoginBusinessModel = LoginBusinessModel(loginApi, loginStorage)

    @Test
    fun login_WhenSuccess() = runBlocking {

        val username = coEvery { unsecureExecutorMockk.get() }  returns "João da Silva"

        val result = loginBusinessModel.login("João da Silva", "123D")

        Assert.assertEquals(result,true)
    }

}



