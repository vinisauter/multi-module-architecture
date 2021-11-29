package com.example.journey.login.tracking

import android.os.Parcelable
import com.example.tagging.Tagging
import com.example.tagging.Tagging.Event
import com.example.tagging.Tagging.ScreenName
import kotlinx.parcelize.Parcelize

// TODO IMPORTANT FOR GENERIC TRACKING: (force forum maybe)
//  Define journey tasks that can SUCCEED or FAIL and create a PATTERN to make tracking generic

// login tracking abstraction with default values
// maybe good pattern to also define view model methods
@Parcelize
data class LoginTracking(
    //LoginFragment
    var loginScreenName: Tagging = ScreenName("login"),
    var loginClickAuthEvent: Tagging = Event("login", "click", "auth"),
    var loginAuthSucceededEvent: Tagging = Event("login", "auth", "succeeded"),
    var loginAuthFailedEvent: Tagging = Event("login", "auth", "failed"),
    var loginClickForgotPasswordEvent: Tagging = Event("login", "click", "forgot_password"),
    val loginForgotPasswordSucceededEvent: Tagging = Event("login", "forgot_password", "succeeded"),
    val loginForgotPasswordFailedEvent: Tagging = Event("login", "forgot_password", "failed"),
    //ForgotPasswordFragment
    var forgotPasswordScreenName: Tagging = ScreenName("forgot_password"),
    var forgotPasswordClickExitEvent: Tagging = Event("forgot_password", "click", "exit"),
) : Parcelable