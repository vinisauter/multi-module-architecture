package com.example.login.business.repository.remote

import com.example.login.InstantExecutorRule
import com.example.networking.RequestExecutor
import io.mockk.coEvery
import io.mockk.coJustRun
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.test.runTest
import org.junit.Assert.*
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4

@ExperimentalCoroutinesApi
@RunWith(JUnit4::class)
internal class LoginApiTest {

    @get:Rule
    val rule = InstantExecutorRule()

    private lateinit var api: LoginApi

    private val unsecureRequestExecutor = mockk<RequestExecutor>()
    private val secureRequestExecutor = mockk<RequestExecutor>()

    @Before
    fun setup() {
        api = LoginApi(unsecureRequestExecutor, secureRequestExecutor)
    }


    @Test
    fun `should return user when login request`() {
        val expected = "João da Silva"

        coJustRun { unsecureRequestExecutor.get() }

        rule.testScope.runTest {
            val result = api.login("user", "password")
            assertEquals(expected, result)
        }

        coVerify {
            unsecureRequestExecutor.get()
        }


    }


}