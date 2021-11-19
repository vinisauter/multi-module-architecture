package com.example.home

import com.example.home.di.homeModule
import org.koin.core.context.loadKoinModules

class HomeLauncher {

    init {
        loadKoinModules(homeModule)
    }

}