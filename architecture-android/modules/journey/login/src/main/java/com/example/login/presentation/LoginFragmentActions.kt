package com.example.login.presentation

import com.core.base.BaseViewEffect
import com.core.base.BaseViewEvent

/**
 * Event  = EVENT where the screen interacts with a use case
 * */
sealed class LoginFragmentEvent : BaseViewEvent {
    object OnScreenLoad : LoginFragmentEvent()
    object OnLogin : LoginFragmentEvent()
    object OnForgotPassword : LoginFragmentEvent()
    object OnBackPressed : LoginFragmentEvent()
}

/**
 * Effect = EFFECT that a use case has on the screen
 * */
sealed class LoginFragmentEffect : BaseViewEffect {
    object Exit : LoginFragmentEffect()
    object LoginSucceed : LoginFragmentEffect()
    object LoginFailed : LoginFragmentEffect()
    object ForgotPassword : LoginFragmentEffect()
    data class Error(val message: String) : LoginFragmentEffect()
}
