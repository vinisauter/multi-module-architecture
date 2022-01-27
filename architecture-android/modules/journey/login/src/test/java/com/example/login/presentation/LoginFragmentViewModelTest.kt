package com.example.login.presentation

import android.app.Application
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.Observer
import androidx.lifecycle.SavedStateHandle
import app.cash.turbine.test
import com.core.extensions.State
import com.example.journey.login.tracking.LoginTracking
import com.example.tagging.TaggingExecutor
import io.mockk.*
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import junit.framework.Assert.assertEquals
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.runBlocking
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import kotlin.time.ExperimentalTime

@ExperimentalTime
@ExperimentalCoroutinesApi
internal class LoginFragmentViewModelTest {

    @get:Rule
    val instantExecutorRule = InstantTaskExecutorRule()

    @MockK
    lateinit var app: Application

    @MockK
    lateinit var savedStateHandle: SavedStateHandle

    @MockK
    lateinit var tagging: TaggingExecutor

    @MockK
    lateinit var useCase: LoginFragmentUseCase

    @MockK(relaxed = true, relaxUnitFun = true)
    lateinit var tracking: LoginTracking

    @InjectMockKs
    lateinit var subject: LoginFragmentViewModel

    @Before
    @Throws(Exception::class)
    fun setUp() {
        MockKAnnotations.init(this, relaxUnitFun = true)
    }

    @Test
    fun `on login change loader state`() {
        //GIVEN
        val observer = mockk<Observer<State>> { every { onChanged(any()) } just Runs }
        subject.onStateChanged.observeForever(observer)
        coEvery { useCase.login(any(), any()) } returns true
        // WHEN
        subject.onLoginClicked()
        // THEN
        verifySequence {
            observer.onChanged(State.Idle)
            observer.onChanged(State.Running)
            observer.onChanged(State.Idle)
        }
    }

    @Test
    fun `on login succeed set action to direction login succeed`() {
        //GIVEN
        coEvery { useCase.login(any(), any()) } returns true
        // whenever(useCase.login(any(), any())).thenReturn(true)
        // WHEN
        subject.onLoginClicked()
        // THEN
        runBlocking(Dispatchers.Default) {
            subject.onActionCompleted.test {
                assertEquals(LoginFragmentDirections.actionLoginSucceed(), expectItem())
            }
        }
    }

    @Test
    fun `on login failed set action to direction login succeed`() {
        //GIVEN
        coEvery { useCase.login(any(), any()) } returns false
        // WHEN
        subject.onLoginClicked()
        // THEN
        runBlocking(Dispatchers.Default) {
            subject.onActionCompleted.test {
                assertEquals(LoginFragmentDirections.actionLoginFailed(), expectItem())
            }
        }
    }
}