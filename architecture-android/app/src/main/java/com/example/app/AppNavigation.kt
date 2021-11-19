package com.example.app

import android.view.View
import androidx.navigation.NavController
import androidx.navigation.findNavController

class AppNavigation {

    fun toHome(navController: NavController) {
        navController.navigate(R.id.action_mainFragment_to_homeNav)
    }

    fun toLogin(view: View) {
        view.findNavController().navigate(R.id.action_mainFragment_to_loginNav)
    }

}