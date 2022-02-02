package com.example.login.presentation

import android.app.Application
import androidx.lifecycle.Observer
import androidx.lifecycle.SavedStateHandle
import com.core.extensions.State
import com.example.journey.login.tracking.LoginTracking
import com.example.login.InstantExecutorRule
import com.example.login.test
import com.example.tagging.TaggingExecutor
import io.mockk.*
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.kotlin.*

@ExperimentalCoroutinesApi
@RunWith(JUnit4::class)
internal class LoginFragmentViewModelTest {
    @get:Rule
    var rule = InstantExecutorRule()

    //MOCK
    lateinit var useCase: LoginFragmentUseCase

    //SUBJECT
    lateinit var vm: LoginFragmentViewModel

    @Before
    fun setUp() {
        useCase = mock()
        val app: Application = mock()
        val savedStateHandle = SavedStateHandle()
        val tagging: TaggingExecutor = mock()
        val tracking = LoginTracking()
        vm = LoginFragmentViewModel(app, savedStateHandle, tagging, useCase, tracking)
    }

    @After
    fun tearDown() {
    }

    //TODO: Run class test in parallel not working
    @Test
    fun `onLoginClicked() - change loader state`() = rule.testScope.runTest {
        //GIVEN
        val observer = mockk<Observer<State>> { every { onChanged(any()) } just Runs }
        vm.onStateChanged.observeForever(observer)
        useCase.stub { onBlocking { useCase.login(any(), any()) }.doReturn(true) }
        // WHEN
        vm.onLoginClicked()
        // THEN
        verifySequence {
            observer.onChanged(State.Idle)
            observer.onChanged(State.Running)
            observer.onChanged(State.Idle)
        }
        println("onLoginClicked() - change loader state")
    }

    //TODO: Run class test in parallel not working
    @Test
    fun `onLoginClicked() - on succeed set direction`() = rule.testScope.runTest {
        //GIVEN
        val observer = vm.onActionCompleted.test(this)
        useCase.stub { onBlocking { useCase.login(any(), any()) }.doReturn(true) }
        // WHEN
        vm.onLoginClicked()
        // THEN
        observer.assertValues(LoginFragmentDirections.actionLoginSucceed())
        observer.finish()
        println("onLoginClicked() - on succeed set direction")
    }

    //TODO: Run class test in parallel not working
    @Test
    fun `onLoginClicked() - on failed set direction`() = rule.testScope.runTest {
        //GIVEN
        val observer = vm.onActionCompleted.test(this)
        whenever(useCase.login(any(), any())).thenReturn(false)
        // WHEN
        vm.onLoginClicked()
        // THEN
        observer.assertValues(LoginFragmentDirections.actionLoginFailed())
        observer.finish()
        println("onLoginClicked() - on succeed set direction")
    }

    @Test
    fun `onLoginClicked() - on exception set direction`() = rule.testScope.runTest {
        //GIVEN
        val observer = vm.onActionCompleted.test(this)
        whenever(useCase.login(any(), any())).thenThrow(NullPointerException("Exception message"))
        // WHEN
        vm.onLoginClicked()
        // THEN
        observer.assertValues(LoginFragmentDirections.actionLoginFailed())
        observer.finish()
        println("onLoginClicked() - on succeed set direction")
    }
}