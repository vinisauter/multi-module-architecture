package com.example.login.business

import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.local.LoginStorageInterface
import com.example.login.business.repository.remote.LoginApi
import com.example.login.business.repository.remote.LoginApiInterface
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
import org.mockito.kotlin.argumentCaptor
import org.mockito.kotlin.doReturn
import org.mockito.kotlin.mock

@RunWith(JUnit4::class)
internal class LoginBusinessModelTest {

    private val NAME = "João da Silva"
    private val PASSWORD = "123D"

    private lateinit var secureExecutorMock: RequestExecutor //Mockito
    private lateinit var unsecureExecutorMock: RequestExecutor //Mockito

    private lateinit var loginApiMockito: LoginApiInterface //Mockito
    private lateinit var loginStorageMockito: LoginStorageInterface //Mockito

    private lateinit var secureExecutorMockk: RequestExecutor //Mockk
    private lateinit var unsecureExecutorMockk: RequestExecutor //Mockk

    private lateinit var loginApiMockk: LoginApi  //Mockk
    private lateinit var loginStorageMockk: LoginStorage  //Mockk

    private lateinit var loginApiImplMockk: LoginApi //Concrete impl, mocked args
    private lateinit var loginApiImplMockito: LoginApi //Concrete impl, mocked args

    private lateinit var loginBusinessModelWithMockk: LoginBusinessModel
    private lateinit var loginBusinessModelConcreteMockk: LoginBusinessModel

    private lateinit var loginBusinessModelWithMockito: LoginBusinessModel
    private lateinit var loginBusinessModelConcreteMockito: LoginBusinessModel

    @Before
    fun setUp() {
        secureExecutorMock = mock() //Mockito
        unsecureExecutorMock = mock() //Mockito

        loginApiMockito = mock() //Mockito
        loginStorageMockito = mock() //Mockito

        secureExecutorMockk = mockk() //Mockk
        unsecureExecutorMockk = mockk() //Mockk

        loginApiMockk = mockk() //Mockk
        loginStorageMockk = mockk() //Mockk

        loginApiImplMockk = LoginApi(unsecureExecutorMockk, secureExecutorMockk) //Concrete impl, mocked args
        loginApiImplMockito = LoginApi(unsecureExecutorMock, secureExecutorMock) //Concrete impl, mocked args

        loginBusinessModelWithMockk = LoginBusinessModel(loginApiMockk, loginStorageMockk)
        loginBusinessModelWithMockito = LoginBusinessModel(loginApiMockito, loginStorageMockito)
        loginBusinessModelConcreteMockk = LoginBusinessModel(loginApiImplMockk, loginStorageMockk)
        loginBusinessModelConcreteMockito = LoginBusinessModel(loginApiImplMockito, loginStorageMockito)
    }

    @After
    fun tearDown() {
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsLogin_OnLoginBusinessModel_returnsTrue_withMockk() = runTest {
        //When using Mockk it is required to define the return for all method calls made within the tested method scope
        coEvery { loginApiMockk.login(anyString(), anyString()) } returns anyString()
        coEvery { loginStorageMockk.save(anyString()) } returns Unit
        val result = loginBusinessModelWithMockk.login(anyString(), anyString())
        assertEquals(result, true)
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsLogin_OnLoginBusinessModel_returnsTrue_withMockito() = runTest {
        val result = loginBusinessModelWithMockito.login(anyString(), anyString())
        assertEquals(result, true)
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsSave_onStorage_savedNameIsTheSameReceivedFromApi_withMockk() = runTest {
        lateinit var name : String
        coEvery { loginApiMockk.login(anyString(), anyString()) } returns NAME
        //It does not work with anyString() and i don't know why
        coEvery { loginStorageMockk.save(any()) } answers { name = firstArg() }
        loginBusinessModelWithMockk.login(anyString(), anyString())
        assertEquals(NAME, name)
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsSave_onStorage_savedNameIsTheSameReceivedFromApi_withMockito() = runTest {
        val captor = argumentCaptor<String>()
        `when`(loginApiMockito.login(anyString(), anyString())).doReturn(NAME)
        `when`(loginStorageMockito.save(captor.capture())).thenReturn(Unit)
        loginBusinessModelWithMockito.login(anyString(), anyString())
        assertEquals(NAME,  captor.firstValue)
    }

    @ExperimentalCoroutinesApi
    @Test
    fun callsLogin_onApi_apiMethodIsCalledOnce_withMockito() = runTest {
        `when`(loginApiMockito.login(anyString(), anyString())).thenReturn(NAME)
        loginBusinessModelWithMockito.login(anyString(), anyString())
        verify(loginApiMockito, times(1)).login(anyString(), anyString())
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
    fun callsSave_onStorage_storageMethodIsCalledOnce_withMockito() = runTest {
        `when`(loginApiMockito.login(anyString(), anyString())).thenReturn(NAME)
        loginBusinessModelWithMockito.login(anyString(), anyString())
        verify(loginStorageMockito, times(1)).save(anyString())
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
    fun callsLogin_onBusinessModel_apiMethodCalledFirstStorageMethodCalledSecond_withMockito() = runTest {
        val inOrder = inOrder(loginApiMockito, loginStorageMockito)
        `when`(loginApiMockito.login(anyString(), anyString())).thenReturn(NAME)
        loginBusinessModelWithMockito.login(NAME, PASSWORD)
        inOrder.verify(loginApiMockito).login(NAME, PASSWORD)
        inOrder.verify(loginStorageMockito).save(NAME)
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
    fun callsLogin_onBusinessModel_unsecureExecutorMethodIsCalled_withMockito() = runTest {
        `when`(unsecureExecutorMock.get()).thenReturn(NAME)
        loginBusinessModelConcreteMockito.login(NAME, PASSWORD)
        verify(unsecureExecutorMock, times(1)).get()
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
    fun callsLogin_onBusinessModel_secureExecutorMethodIsCalledOnce_withMockito() = runTest {
        `when`(secureExecutorMock.post()).thenReturn(NAME)
        loginBusinessModelConcreteMockito.login(NAME, PASSWORD)
        verify(secureExecutorMock, times(1)).post()
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