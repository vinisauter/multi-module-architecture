package com.example.login

import android.injection.get
import android.injection.module
import androidx.navigation.navArgs
import com.core.base.ModuleController
import com.example.journey.login.tracking.LoginTracking
import com.example.login.business.LoginBusinessModel
import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi
import com.example.networking.RequestExecutor
import com.example.storage.StorageExecutor

class LoginController : ModuleController(R.navigation.login_navigation_graph) {
    private val args: LoginControllerArgs by navArgs()
    private val tracking: LoginTracking by lazy { args.tracking ?: LoginTracking() }

    override fun dependencies() = module("LOGIN") {
        declare<LoginTracking> { tracking }
        sharedWithSuperClasses<LoginBusinessModel> {
            val secureRequestExecutor: RequestExecutor = get(qualifier = "secure")
            val unsecureRequestExecutor: RequestExecutor = get(qualifier = "unsecure")
            val api = LoginApi(unsecureRequestExecutor, secureRequestExecutor)

            val storageExecutor: StorageExecutor = get()
            val storage = LoginStorage(storageExecutor)

            LoginBusinessModel(api, storage)
        }
        // declareWithSuperClasses/sharedWithSuperClasses<LoginBusinessModel>
        //  WithSuperClasses is equivalent to definition of the class and all super classes:
        //  declare/shared<LoginBusinessModel>
        //  declare/shared<LoginFragmentUseCase>
        //  declare/shared<ForgotPasswordFragmentUseCase>
    }
}