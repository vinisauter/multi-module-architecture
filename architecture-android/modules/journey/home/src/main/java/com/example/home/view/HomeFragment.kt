package com.example.home.view

import com.example.app.base.BaseLauncher
import com.example.app.base.LauncherFragment
import com.example.home.HomeLauncher


class HomeFragment : LauncherFragment() {
    override val launcher: BaseLauncher = HomeLauncher

    override fun execute() {}

}