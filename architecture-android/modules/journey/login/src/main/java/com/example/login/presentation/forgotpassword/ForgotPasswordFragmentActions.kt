package com.example.login.presentation.forgotpassword

import androidx.navigation.NavDirections
import com.core.base.BaseViewEffect
import com.core.base.BaseViewEvent

sealed class ForgotPasswordFragmentEvent : BaseViewEvent {
    object OnScreenLoad : ForgotPasswordFragmentEvent()
}

sealed class ForgotPasswordFragmentEffect : BaseViewEffect {
    object ShowLoader : ForgotPasswordFragmentEffect()
    object HideLoader : ForgotPasswordFragmentEffect()
    object Exit : ForgotPasswordFragmentEffect()
    // TODO: make effect for each direction? or keep direction from xml?
    //  ViewModel with SafeArgs NavDirections dependency or ViewModel with only action state dependency?
    data class Direction(val direction: NavDirections) : ForgotPasswordFragmentEffect()
}
