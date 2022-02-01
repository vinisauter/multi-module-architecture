package com.example.login.presentation

import android.app.Application
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.Observer
import androidx.lifecycle.SavedStateHandle
import com.core.extensions.State
import com.example.journey.login.tracking.LoginTracking
import com.example.tagging.TaggingExecutor
import io.mockk.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.*
import org.junit.*
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.kotlin.any
import org.mockito.kotlin.doReturn
import org.mockito.kotlin.mock
import org.mockito.kotlin.stub

@ExperimentalCoroutinesApi
@RunWith(JUnit4::class)
internal class LoginFragmentViewModelTest {
    @get:Rule
    var rule = InstantTaskExecutorRule()

    companion object {
        private val testDispatcher by lazy { UnconfinedTestDispatcher() }
        private val testScope by lazy { TestScope(testDispatcher) }

        @JvmStatic
        @BeforeClass
        fun prepare() {
            Dispatchers.setMain(testDispatcher)
        }

        @JvmStatic
        @AfterClass
        fun cleanup() {
            Dispatchers.resetMain()
        }
    }

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

    @Test
    fun `onLoginClicked() - change loader state`() = testScope.runTest {
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
}