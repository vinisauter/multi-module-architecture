package com.example.login.presentation

import io.mockk.MockKAnnotations
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import org.junit.Before
import org.junit.Test


class LoginFragmentTest {
//class LoginFragmentTest : TestCase() {

    @MockK
    lateinit var viewModel: LoginFragmentViewModel

    @InjectMockKs
    var subject = LoginFragment()

    @Before
    @Throws(Exception::class)
    fun setUp() =
        MockKAnnotations.init(this, relaxUnitFun = true)

    @Test
    fun afterViews() {
    }
}