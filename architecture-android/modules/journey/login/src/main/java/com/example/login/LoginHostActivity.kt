package com.example.login

import android.injection.Module
import android.injection.get
import androidx.navigation.navArgs
import com.core.base.BaseHostActivity
import com.example.journey.login.tracking.LoginTracking
import com.example.login.core.Login
import com.example.login.core.repository.local.LoginStorage
import com.example.login.core.repository.remote.LoginApi
import com.example.networking.RequestExecutor
import com.example.storage.StorageExecutor

class LoginHostActivity : BaseHostActivity(R.navigation.login_navigation_graph) {
    private val args: LoginControllerActivityArgs by navArgs()
    private val tracking: LoginTracking by lazy { args.tracking ?: LoginTracking() }

    override fun Module.dependencies() {
        shared<LoginTracking> { tracking }
        shared<Login> {
            val secureRequestExecutor: RequestExecutor = get(qualifier = "secure")
            val unsecureRequestExecutor: RequestExecutor = get(qualifier = "unsecure")
            val api = LoginApi(unsecureRequestExecutor, secureRequestExecutor)

            val storageExecutor: StorageExecutor = get()
            val storage = LoginStorage(storageExecutor)

            Login(api, storage)
        }
    }
}