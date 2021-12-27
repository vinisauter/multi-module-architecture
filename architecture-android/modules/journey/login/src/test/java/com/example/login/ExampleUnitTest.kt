package com.example.login

import android.app.Application
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.SavedStateHandle
import com.example.journey.login.tracking.LoginTracking
import com.example.login.presentation.LoginFragmentUseCase
import com.example.login.presentation.LoginFragmentViewModel
import com.example.tagging.Tagging
import com.example.tagging.TaggingExecutor
import com.nhaarman.mockitokotlin2.*
import kotlinx.coroutines.*
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.runTest
import kotlinx.coroutines.test.setMain
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.mockito.ArgumentMatchers.anyString
import org.mockito.Mockito.`when`

class ExampleUnitTest {

    private val oneSecond: Long = 1000

    private val tracking = LoginTracking()

    private lateinit var tagging : TaggingExecutor

    private lateinit var useCase : LoginFragmentUseCase

    @DelicateCoroutinesApi
    private val mainThreadSurrogate = newSingleThreadContext("UI thread")

    @get:Rule
    var instantTaskExecutorRule = InstantTaskExecutorRule()

    @ExperimentalCoroutinesApi
    @DelicateCoroutinesApi
    @Before
    fun createMocks() {
        tagging = mock()
        useCase = mock()

        Dispatchers.setMain(mainThreadSurrogate)
    }

    @DelicateCoroutinesApi
    @ExperimentalCoroutinesApi
    @After
    fun clearResources() {
        Dispatchers.resetMain()
        mainThreadSurrogate.close()
    }

    @Test
    fun trackLoginScreenName_onLoginViewCreated_sendLoginScreenName() {
        val captor = argumentCaptor<Tagging.ScreenName>()
        val loginFragmentViewModel = LoginFragmentViewModel(Application(), SavedStateHandle(), tagging, useCase, tracking)
        loginFragmentViewModel.onLoginViewCreated()
        verify(tagging, times(1)).send(captor.capture())
        assert(captor.firstValue.screenName == ((tracking.loginScreenName) as Tagging.ScreenName).screenName)
    }

    @ExperimentalCoroutinesApi
    @Test
    fun trackLoginClick_onLoginClick_sendLoginClickEvent() {
        val captor = argumentCaptor<Tagging.Event>()
        val loginFragmentViewModel = LoginFragmentViewModel(Application(), SavedStateHandle(), tagging, useCase, tracking)
        return runTest {
            loginFragmentViewModel.onLoginClicked()
            delay(oneSecond)
            verify(tagging, atLeastOnce()).send(captor.capture())
            assert(captor.firstValue.label == ((tracking.loginClickAuthEvent) as Tagging.Event).label)
        }
    }

    @ExperimentalCoroutinesApi
    @Test
    fun trackLoginSuccess_onLoginSuccess_sendLoginSuccessEvent() {
        val captor = argumentCaptor<Tagging.Event>()
        val loginFragmentViewModel = LoginFragmentViewModel(Application(), SavedStateHandle(), tagging, useCase, tracking)
        return runTest {
            `when`(useCase.login(anyString(), anyString())).thenReturn(true)
            loginFragmentViewModel.onLoginClicked()
            delay(oneSecond)
            verify(tagging, atLeastOnce()).send(captor.capture())
            assert(captor.secondValue.label == ((tracking.loginAuthSucceededEvent) as Tagging.Event).label)
        }
    }

    @ExperimentalCoroutinesApi
    @Test
    fun trackLoginFail_onLoginFail_sendLoginFailEvent() {
        val captor = argumentCaptor<Tagging.Event>()
        val loginFragmentViewModel = LoginFragmentViewModel(Application(), SavedStateHandle(), tagging, useCase, tracking)
        return runTest {
            `when`(useCase.login(anyString(), anyString())).thenReturn(false)
            loginFragmentViewModel.onLoginClicked()
            delay(oneSecond)
            verify(tagging, atLeastOnce()).send(captor.capture())
            assert(captor.secondValue.label == ((tracking.loginAuthFailedEvent) as Tagging.Event).label)
        }
    }

    //Use of runBlocking to show the difference from runTest
    //The use of runBlocking in place of runTest makes the time delay to actually take some time, so this approach is not desirable
    @ExperimentalCoroutinesApi
    @Test
    fun callUseCaseLogin_onLoginClick_callLoginOnce() {
        val loginFragmentViewModel = LoginFragmentViewModel(Application(), SavedStateHandle(), tagging, useCase, tracking)
        runBlocking {
            loginFragmentViewModel.onLoginClicked()
            delay(oneSecond)
            verify(useCase, times(1)).login(anyString(), anyString())
        }
    }

    //TODO Make it pass
    @ExperimentalCoroutinesApi
    @Test
    fun testLoginResult() {
        return runTest {
            val loginFragmentViewModel = LoginFragmentViewModel(Application(), SavedStateHandle(), tagging, useCase, tracking)
            loginFragmentViewModel.onLoginClicked()
            delay(oneSecond)
            //assert(loginFragmentViewModel.onStateChanged.value == StateResult.Initial)
            //assert(loginFragmentViewModel.onStateChanged.value == StateResult.Loading)
        }
    }
}