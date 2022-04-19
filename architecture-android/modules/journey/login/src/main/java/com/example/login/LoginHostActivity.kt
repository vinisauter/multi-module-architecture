package com.example.login

import androidx.navigation.navArgs
import com.core.base.BaseHostActivity
import com.example.journey.login.tracking.LoginTracking

class LoginHostActivity : BaseHostActivity<LoginProvider>(R.navigation.login_navigation_graph) {
    private val args: LoginHostActivityArgs by navArgs()
    private val tracking: LoginTracking by lazy { args.tracking ?: LoginTracking() }

    override val dependenciesProvider: LoginProvider
        get() = LoginProvider(tracking)
}