package com.example.journey

import androidx.lifecycle.lifecycleScope
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
            val state = args.navState
//            findNavController().navigate(R.id.navigation_activity)

            findNavController().navigate(args.destination, arguments)
            dismiss()
        }
    }
}