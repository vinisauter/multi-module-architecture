package com.example.login.business.repository.local


import com.example.login.InstantExecutorRule
import com.example.storage.StorageExecutor
import io.mockk.*
import junit.framework.TestCase
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.test.runTest
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4

@ExperimentalCoroutinesApi
@RunWith(JUnit4::class)
internal class LoginStorageTest : TestCase() {

    @get:Rule
    val rule = InstantExecutorRule()

    //mockar storage executor
    private val executor = mockk<StorageExecutor>(relaxed = true)

    //class que sera testada - declara
    private lateinit var storage: LoginStorage

    //before é um setup do teste - inicializa
    @Before
    fun setup() {
        storage = LoginStorage(executor)
    }

    @Test
    fun `should save string when receives string`() {

        //estamos executando uma coroutine por isso usamos no runblock
        rule.testScope.runTest { storage.save("name") }

        //verificação
        coVerify {
            executor.put("user", "name")
        }
    }


}