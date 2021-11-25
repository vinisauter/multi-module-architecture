package com.example.journey.login.tracking

import android.os.Parcelable
import com.core.analytics.Event
import com.core.analytics.ScreenName
import kotlinx.parcelize.Parcelize

// TODO IMPORTANT FOR GENERIC TRACKING: (force forum maybe)
//  Define journey tasks that can SUCCEED or FAIL and create a PATTERN to make tracking generic

// login tracking abstraction with default values
// maybe good pattern to also define view model methods
@Parcelize
data class LoginTracking(
    //LoginFragment
    var loginScreenName: ScreenName = "login",
    var loginClickAuthEvent: Event = Event("login", "click", "auth"),
    var loginAuthSucceededEvent: Event = Event("login", "auth", "succeeded"),
    var loginAuthFailedEvent: Event = Event("login", "auth", "failed"),
    var loginClickForgotPasswordEvent: Event = Event("login", "click", "forgot_password"),
    val loginForgotPasswordSucceededEvent: Event = Event("login", "forgot_password", "succeeded"),
    val loginForgotPasswordFailedEvent: Event = Event("login", "forgot_password", "failed"),
    //ForgotPasswordFragment
    var forgotPasswordScreenName: ScreenName = "forgot_password",
    var forgotPasswordClickExitEvent: Event = Event("forgot_password", "click", "exit"),
) : Parcelable