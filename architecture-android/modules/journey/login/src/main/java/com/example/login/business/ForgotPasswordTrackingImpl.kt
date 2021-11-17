package com.example.login.business

import com.core.logger.Logger
import com.example.login.presentation.forgotpassword.ForgotPasswordFragmentTracking

class ForgotPasswordTrackingImpl : ForgotPasswordFragmentTracking {
    override fun onForgotPasswordViewCreated() {
        Logger.log("event screen name forgot password")
    }

    override fun onExitClicked() {
        Logger.log("event exit")
    }
}