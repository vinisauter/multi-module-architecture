package com.example.journey

import android.os.Bundle
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavController
import androidx.navigation.NavDestination
import androidx.navigation.dynamicfeatures.DynamicExtras
import androidx.navigation.dynamicfeatures.DynamicInstallMonitor
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import com.core.base.LoaderDialog
import kotlinx.coroutines.launch

class NavigationLauncher : LoaderDialog() {
    private val args: NavigationLauncherArgs by navArgs()
    override fun onStart() {
        super.onStart()
        lifecycleScope.launch {
            // TODO validate args & deep link to module navigation destination
//            val state = args.navState
//            findNavController().navigate(R.id.navigation_activity)
            val navController = findNavController()

            val installMonitor = DynamicInstallMonitor()
            val dynamicExtras = DynamicExtras(installMonitor)
            navController.navigate(
                args.destinationId,
                arguments,
                null,
                dynamicExtras
            )
            if ("activity" == navController.findDestination(args.destinationId)?.navigatorName) {
                dismiss()
                requireActivity().finish()
            }
        }
    }
}