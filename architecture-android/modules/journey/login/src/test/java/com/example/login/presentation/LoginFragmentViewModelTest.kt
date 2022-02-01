package com.example.login.presentation

import android.app.Application
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.SavedStateHandle
import com.example.journey.login.tracking.LoginTracking
import com.example.tagging.TaggingExecutor
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.kotlin.mock

@RunWith(JUnit4::class)
internal class LoginFragmentViewModelTest {
    @get:Rule
    var rule = InstantTaskExecutorRule()

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
    fun `on login change loader state`() {
        // GIVEN
        // WHEN
        vm.onLoginClicked()
        // THEN
    }
}