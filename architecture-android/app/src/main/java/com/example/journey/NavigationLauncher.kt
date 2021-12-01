package com.example.journey

import androidx.annotation.NavigationRes
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavController
import androidx.navigation.NavGraph
import androidx.navigation.dynamicfeatures.DynamicExtras
import androidx.navigation.dynamicfeatures.DynamicInstallMonitor
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import com.core.base.LoaderDialog
import com.example.app.R
import kotlinx.coroutines.launch

// TODO replace with tag launcher?
//  ```
//      <launcher android:id="@+id/my_launcher"
//               android:graph="@navigation/app_navigation_graph"/>
//  ```
//  https://gist.github.com/fbarthelery/ad0062a88875b46e0065137ff03807a0
class NavigationLauncher : LoaderDialog() {
    private val args: NavigationLauncherArgs by navArgs()
    override fun onStart() {
        super.onStart()
        lifecycleScope.launch {
            val navController = findNavController()

            if (navController.findDestination(args.destinationId) == null) {
                navController.includeDestinationsFromGraph(
                    R.navigation.app_navigation_graph
                )
            }
            val installMonitor = DynamicInstallMonitor()
            val dynamicExtras = DynamicExtras(installMonitor)
            navController.navigate(
                args.destinationId,
                arguments,
                null,
                dynamicExtras
            )
            // TODO: validate when should close loader
            when (navController.findDestination(args.destinationId)?.navigatorName) {
                "activity" -> {
                    dismiss()
                    // TODO: finish optional?
                    requireActivity().finish()
                }
                else -> {
                    //TODO: close loader
                    // navController.popBackStack()?
                    // dismiss()?
                    // NavOptions?
                }
            }
        }
    }

    private fun NavController.includeDestinationsFromGraph(@NavigationRes graphResId: Int) {
        val sharedDestinations: NavGraph = navInflater.inflate(graphResId)
        graph.addAll(sharedDestinations)
    }
}