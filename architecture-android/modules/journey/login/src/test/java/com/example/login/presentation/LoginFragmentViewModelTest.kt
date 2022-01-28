package com.example.login.presentation

import androidx.lifecycle.Observer
import androidx.lifecycle.SavedStateHandle
import com.core.extensions.State
import com.example.journey.login.tracking.LoginTracking
import com.example.login.TaskScopeExecutorRule
import io.mockk.*
import junit.framework.TestCase.assertEquals
import kotlinx.coroutines.flow.single
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.kotlin.any
import org.mockito.kotlin.doReturn
import org.mockito.kotlin.mock
import org.mockito.kotlin.stub

@RunWith(JUnit4::class)
internal class LoginFragmentViewModelTest {
    @get:Rule
    var rule = TaskScopeExecutorRule()

    //MOCK
    lateinit var useCase: LoginFragmentUseCase

    //SUBJECT
    lateinit var vm: LoginFragmentViewModel

    @Before
    fun setUp() {
        useCase = mock()
        vm = LoginFragmentViewModel(mock(), SavedStateHandle(), mock(), useCase, LoginTracking())
    }

    @Test
    fun `on login change loader state`() = rule.launchTest {
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
    }

    @Test
    fun `on login succeed set action to direction login succeed`() = rule.launchTest {
        //GIVEN
        useCase.stub { onBlocking { useCase.login(any(), any()) }.doReturn(true) }
        // WHEN
        vm.onLoginClicked()
        // THEN
        vm.onActionCompleted.collect {
            assertEquals(LoginFragmentDirections.actionLoginSucceed(), it)
        }
    }

    @Test
    fun `on login failed set action to direction login succeed`() = rule.launchTest {
        //GIVEN
        useCase.stub { onBlocking { useCase.login(any(), any()) }.doReturn(true) }
        // WHEN
        vm.onLoginClicked()
        // THEN
        val result = vm.onActionCompleted.single()
        assertEquals(LoginFragmentDirections.actionLoginFailed(), result)
    }
}