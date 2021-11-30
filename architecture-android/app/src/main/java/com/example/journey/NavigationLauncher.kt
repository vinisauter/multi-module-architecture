package com.example.journey

import androidx.lifecycle.lifecycleScope
import androidx.navigation.dynamicfeatures.DynamicExtras
import androidx.navigation.dynamicfeatures.DynamicInstallMonitor
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import com.core.base.LoaderDialog
import com.example.app.R
import kotlinx.coroutines.launch

class NavigationLauncher : LoaderDialog() {
    private val args: NavigationLauncherArgs by navArgs()
    override fun onStart() {
        super.onStart()
        lifecycleScope.launch {
            // TODO validate args & deep link to module navigation destination
            val state = args.navState
//            findNavController().navigate(R.id.navigation_activity)

            val installMonitor = DynamicInstallMonitor()
            val dynamicExtras = DynamicExtras(installMonitor)
            val destination = mapRoute(args.destination)
            findNavController().navigate(destination, arguments, null, dynamicExtras)
            dismiss()
        }
    }

    private fun mapRoute(route: String) = when (route){
        resources.getString(R.string.route_login) -> R.id.login_navigation
        resources.getString(R.string.route_home) -> R.id.home_navigation
        resources.getString(R.string.route_profile) -> R.id.profile_navigation
        resources.getString(R.string.route_splash) -> R.id.splash
        else -> R.id.login_navigation
    }
}