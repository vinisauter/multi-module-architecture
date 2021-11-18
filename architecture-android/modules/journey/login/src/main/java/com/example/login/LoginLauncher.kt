package com.example.login

import com.example.login.di.loginPresentationModule
import org.koin.core.context.loadKoinModules

class LoginLauncher {

    init {
        loadKoinModules(loginPresentationModule)
    }

}