package com.example.login

import android.injection.Module
import android.injection.get
import androidx.navigation.navArgs
import com.core.base.ModuleControllerActivity
import com.example.journey.login.tracking.LoginTracking
import com.example.login.business.LoginBusinessModel
import com.example.login.business.repository.local.LoginStorage
import com.example.login.business.repository.remote.LoginApi
import com.example.networking.RequestExecutor
import com.example.storage.StorageExecutor

class LoginControllerActivity : ModuleControllerActivity(R.navigation.login_navigation_graph) {
    private val args: LoginControllerActivityArgs by navArgs()
    private val tracking: LoginTracking by lazy { args.tracking ?: LoginTracking() }

    override fun Module.dependencies() {
        shared<LoginTracking> { tracking }
        sharedWithSuperClasses<LoginBusinessModel> {
            val secureRequestExecutor: RequestExecutor = get(qualifier = "secure")
            val unsecureRequestExecutor: RequestExecutor = get(qualifier = "unsecure")
            val api = LoginApi(unsecureRequestExecutor, secureRequestExecutor)

            val storageExecutor: StorageExecutor = get()
            val storage = LoginStorage(storageExecutor)

            LoginBusinessModel(api, storage)
        }
    }
}