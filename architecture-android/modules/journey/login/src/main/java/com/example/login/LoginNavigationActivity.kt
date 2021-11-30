package com.example.login

import android.injection.Module
import android.injection.get
import android.injection.module
import android.os.Bundle
import androidx.navigation.navArgs
import com.core.base.NavigationActivity
import com.core.extensions.default
import com.example.journey.login.tracking.LoginTracking
import com.example.login.business.LoginBusinessModel
import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi

class LoginNavigationActivity : NavigationActivity(R.navigation.login_navigation_graph) {
    private val args: LoginNavigationActivityArgs by navArgs()
    private lateinit var module: Module
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val tracking: LoginTracking = args.tracking.default(LoginTracking())
        // TODO: move to BaseActivity?
        module = module("LOGIN") {
            declare<LoginTracking> { tracking }
            sharedWithSuperClasses<LoginBusinessModel> {
                val api = LoginApi(get())
                val storage = LoginStorage(get())
                LoginBusinessModel(api, storage)
            }
            // declareWithSuperClasses/sharedWithSuperClasses<LoginBusinessModel>
            //  WithSuperClasses is equivalent to definition of all super classes:
            //  declare/shared<LoginBusinessModel>
            //  declare/shared<LoginFragmentUseCase>
            //  declare/shared<ForgotPasswordFragmentUseCase>
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        module.clear()
    }
}