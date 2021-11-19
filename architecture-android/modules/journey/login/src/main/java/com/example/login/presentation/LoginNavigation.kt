package com.example.login.presentation

import android.view.View
import androidx.navigation.NavController
import com.example.app.AppNavigation
import com.example.core.NextBaseNavigation

class LoginNavigation(
    private val mAppNavigation: AppNavigation
) : NextBaseNavigation() {

    fun toHome(navController: NavController) {
        mAppNavigation.toHome(navController)
    }

}