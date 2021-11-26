package com.example.login

import android.injection.*
import android.os.Bundle
import com.core.base.NavigationActivity
import com.example.journey.login.tracking.LoginTracking
import com.example.login.business.LoginBusinessModel
import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi
import com.example.login.presentation.LoginFragmentUseCase

class LoginNavigationActivity : NavigationActivity(R.navigation.login_navigation_graph) {
    lateinit var module: Module
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO ADD MODULES DEPENDENCIES
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
        // TODO REMOVE MODULES DEPENDENCIES
        module.clear()
    }
}