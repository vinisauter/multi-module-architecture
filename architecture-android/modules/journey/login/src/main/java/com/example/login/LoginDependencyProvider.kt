package com.example.login

import com.core.analytics.Tagging
import com.example.journey.login.tracking.LoginTracking
import com.example.login.presentation.LoginFragmentUseCase
import com.example.login.presentation.forgotpassword.ForgotPasswordFragmentUseCase
import com.example.structural.StructuralProvider

object LoginDependencyProvider {
    lateinit var tagging: Tagging
    lateinit var loginUseCase: LoginFragmentUseCase
    lateinit var forgotPasswordUseCase: ForgotPasswordFragmentUseCase
    lateinit var tracking: LoginTracking

    // TODO: by reference args/bundle parameter
    //  var tracking    SOLVED using by value parameter
    //  var tagging     UNSOLVED by reference parameter needed
    //  parameter:
    //      pass by value using Serializable or Parcelable
    //      pass by reference using AIDL (https://developer.android.com/guide/components/aidl?hl=pt-br)
    //      pass by reference using injection (val tagging: Tagging by inject() maybe?)
    fun setup(
        tracking: LoginTracking,
        loginUseCase: LoginFragmentUseCase,
        forgotPasswordUseCase: ForgotPasswordFragmentUseCase,
    ) {
        // TODO: Remover acesso direto ao StructuralProvider
        this.tagging = StructuralProvider.tagging
        this.tracking = tracking
        this.loginUseCase = loginUseCase
        this.forgotPasswordUseCase = forgotPasswordUseCase
    }
}