package com.example.login.business

import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi
import com.example.networking.RequestExecutor
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.coVerifySequence
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.After
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.Mockito.*

@RunWith(JUnit4::class)
internal class LoginBusinessModelTest {

    private val NAME = "João da Silva"
    private val PASSWORD = "123D"

    private lateinit var secureExecutorMockk: RequestExecutor //Mockk
    private lateinit var unsecureExecutorMockk: RequestExecutor //Mockk

    private lateinit var loginApiMockk: LoginApi  //Mockk
    private lateinit var loginStorageMockk: LoginStorage  //Mockk

    private lateinit var loginApiImplMockk: LoginApi //Concrete impl, mocked args

    private lateinit var loginBusinessModelWithMockk: LoginBusinessModel
    private lateinit var loginBusinessModelConcreteMockk: LoginBusinessModel

    @Before
    fun setUp() {

        secureExecutorMockk = mockk() //Mockk
        unsecureExecutorMockk = mockk() //Mockk

        loginApiMockk = mockk() //Mockk
        loginStorageMockk = mockk() //Mockk

        loginApiImplMockk = LoginApi(unsecureExecutorMockk, secureExecutorMockk) //Concrete impl, mocked args

        loginBusinessModelWithMockk = LoginBusinessModel(loginApiMockk, loginStorageMockk)
        loginBusinessModelConcreteMockk = LoginBusinessModel(loginApiImplMockk, loginStorageMockk)
    }

    @After
    fun tearDown() {
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsLogin_OnLoginBusinessModel_returnsTrue_withMockk() = runTest {
        coEvery { loginApiMockk.login(anyString(), anyString()) } returns anyString()
        coEvery { loginStorageMockk.save(anyString()) } returns Unit
        val result = loginBusinessModelWithMockk.login(anyString(), anyString())
        assertEquals(result, true)
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsSave_onStorage_savedNameIsTheSameReceivedFromApi_withMockk() = runTest {
        lateinit var name : String
        coEvery { loginApiMockk.login(anyString(), anyString()) } returns NAME
        coEvery { loginStorageMockk.save(NAME) } answers { name = firstArg() }
        loginBusinessModelWithMockk.login(anyString(), anyString())
        assertEquals(NAME, name)
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsLogin_onApi_apiMethodIsCalledOnce_withMockk() = runTest {
        coEvery { loginApiMockk.login(anyString(), anyString()) } returns NAME
        coEvery { loginStorageMockk.save(NAME) } returns Unit
        loginBusinessModelWithMockk.login(anyString(), anyString())
        coVerify(exactly = 1) { loginApiMockk.login(anyString(), anyString()) }
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsSave_onStorage_storageMethodIsCalledOnce_withMockk() = runTest {
        coEvery { loginApiMockk.login(NAME, PASSWORD) } returns NAME
        coEvery { loginStorageMockk.save(NAME) } returns Unit
        loginBusinessModelWithMockk.login(NAME, PASSWORD)
        coVerify(exactly = 1) { loginStorageMockk.save(NAME) }
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsLogin_onBusinessModel_apiMethodCalledFirstStorageMethodCalledSecond_withMockk() = runTest {
        coEvery { loginApiMockk.login(NAME, PASSWORD) } returns NAME
        coEvery { loginStorageMockk.save(NAME) } returns Unit
        loginBusinessModelWithMockk.login(NAME, PASSWORD)
        coVerifySequence {
            loginApiMockk.login(NAME, PASSWORD)
            loginStorageMockk.save(NAME)
        }
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsLogin_onBusinessModel_unsecureExecutorMethodIsCalled_withMockk() = runTest {
        coEvery { unsecureExecutorMockk.get() } answers { anyString() }
        coEvery { secureExecutorMockk.post() } answers { NAME }
        coEvery { loginStorageMockk.save(NAME) } returns Unit
        loginBusinessModelConcreteMockk.login(anyString(), anyString())
        coVerify(exactly = 1) { unsecureExecutorMockk.get() }
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsLogin_onBusinessModel_secureExecutorMethodIsCalledOnce_withMockk() = runTest {
        coEvery { unsecureExecutorMockk.get() } returns NAME
        coEvery { secureExecutorMockk.post() } returns NAME
        coEvery { loginStorageMockk.save(NAME) } returns Unit
        loginBusinessModelConcreteMockk.login(anyString(), anyString())
        coVerify(exactly = 1) { secureExecutorMockk.post() }
    }
}