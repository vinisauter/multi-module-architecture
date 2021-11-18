package com.example.login.di

import com.example.login.business.LoginBusinessModel
import com.example.login.business.LoginRepositoryImpl
import com.example.login.business.data.LoginLocalDataSource
import com.example.login.presentation.LoginViewModel
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

        LoginRepositoryImpl(
            mLocalDataSource = get(),
            mRemoteDateSource = get()
        )

        LoginLocalDataSource()
    }

}