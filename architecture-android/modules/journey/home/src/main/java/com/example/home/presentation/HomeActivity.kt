package com.example.home.presentation

import android.os.Bundle
import com.example.core.NextBaseActivity
import com.example.home.HomeLauncher
import com.example.home.R
import com.example.home.databinding.ActivityHomeBinding
import org.koin.androidx.viewmodel.ext.android.viewModel

class HomeActivity : NextBaseActivity<ActivityHomeBinding, HomeViewModel, HomeNavigation>() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        HomeLauncher()
    }

    override val mLayoutId: Int = R.layout.activity_home

    override val mViewModel: HomeViewModel by viewModel()
    override val mNavigation: HomeNavigation = HomeNavigation()

}