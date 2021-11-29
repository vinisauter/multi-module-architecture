package com.example.login

import android.injection.*
import android.os.Bundle
import androidx.navigation.navArgs
import com.core.base.NavigationActivity
import com.core.extensions.default
import com.example.journey.login.tracking.LoginTracking
import com.example.login.business.LoginBusinessModel
import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi
import com.example.login.presentation.LoginFragmentUseCase

class LoginNavigationActivity : NavigationActivity(R.navigation.login_navigation_graph) {
    private val args: LoginNavigationActivityArgs by navArgs()
    lateinit var module: Module
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val tracking: LoginTracking = args.loginTracking.default(LoginTracking())

        module =
        module("login") {
            declare<LoginTracking> {
                LoginTracking()// TODO get custom tracking by args
            }
            shared<LoginFragmentUseCase> {
                val api = LoginApi(get())
                val storage = LoginStorage(get())
                LoginBusinessModel(api, storage)
            }
        }
//        addModule(module)
    }

    override fun onDestroy() {
        super.onDestroy()
        module.clear()
    }
}