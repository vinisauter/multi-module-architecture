package com.example.login.di

import android.app.Application
import com.example.app.AppNavigation
import com.example.login.business.LoginBusinessModel
import com.example.login.business.LoginRepositoryImpl
import com.example.login.business.data.LoginLocalDataSource
import com.example.login.business.data.LoginRemoteDateSource
import com.example.login.presentation.LoginNavigation
import com.example.login.presentation.LoginViewModel
import com.example.networking.RequestExecutor
import org.koin.android.ext.koin.androidApplication
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val loginPresentationModule = module {

    viewModel {
        LoginViewModel(
            mBusinessModel = get()
        )
    }

    single {
        LoginBusinessModel(
            mRepository = get()
        )
    }

    single {
        LoginRepositoryImpl(
            mLocalDataSource = get(),
            mRemoteDateSource = get()
        )
    }

    single {
        provideNetwork(application = androidApplication())
    }

    single {
        LoginRemoteDateSource(mNetwork = get())
    }

    single {
        LoginLocalDataSource()
    }

    single {
        AppNavigation()
    }
    
    single {
        LoginNavigation(mAppNavigation = get())
    }
}

private fun provideNetwork(application: Application): RequestExecutor {
    val providerClass = "com.example.structural.networking.RequestExecutorImpl\$Provider"

    val networkProvider = Class.forName(providerClass).kotlin.objectInstance
            as RequestExecutor.Provider

    val dependencies = object : RequestExecutor.Dependencies {
        override fun getApp(): Application {
            return application
        }
    }

    return networkProvider.get(dependencies)
}