package com.example.login.business

import com.core.logger.Logger
import com.example.login.presentation.LoginFragmentTracking

class LoginFragmentTrackingImpl : LoginFragmentTracking {
    override fun onLoginViewCreated() {
        Logger.log("event screen name login")
    }

    override fun onLoginClicked() {
        Logger.log("event login")
    }

    override fun onLoginSucceed() {
        Logger.log("event login succeed")
    }

    override fun onLoginFailed() {
        Logger.log("event login failed")
    }

    override fun onForgotPasswordClicked() {
        Logger.log("event forgot password clicked")
    }
}
