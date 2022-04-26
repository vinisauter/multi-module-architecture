package com.example.login.presentation

import androidx.navigation.NavDirections
import com.core.base.BaseViewEffect
import com.core.base.BaseViewEvent

sealed class LoginFragmentEvent : BaseViewEvent {
    object OnScreenLoad : LoginFragmentEvent()
    object OnLogin : LoginFragmentEvent()
    object OnForgotPassword : LoginFragmentEvent()
    object OnBackPressed : LoginFragmentEvent()
}
// TODO: make effect for each direction? or keep direction from Safe Args?
sealed class LoginFragmentEffect : BaseViewEffect {
    object Exit : LoginFragmentEffect()
    data class Direction(val direction: NavDirections) : LoginFragmentEffect()
}
