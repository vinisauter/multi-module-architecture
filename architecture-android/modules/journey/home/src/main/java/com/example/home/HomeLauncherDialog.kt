package com.example.home

import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavDirections
import androidx.navigation.fragment.navArgs
import com.core.base.LoaderDialog
import com.core.extensions.deepLinkUri
import com.core.extensions.navigate
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class HomeLauncherDialog : LoaderDialog() {
    private val args: HomeLauncherDialogArgs by navArgs()
    private val viewModel: HomeLauncherViewModel by viewModels()
    private val deepLink by deepLinkUri()

    override fun onStart() {
        super.onStart()
        lifecycleScope.launch {
            viewModel.launch(deepLink, args)
            viewModel.onActionCompleted.collect { navDirection: NavDirections ->
                navigate(navDirection)
            }
        }
    }
}
