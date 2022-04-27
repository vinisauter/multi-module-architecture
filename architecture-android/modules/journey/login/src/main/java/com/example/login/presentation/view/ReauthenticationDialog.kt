package com.example.login.presentation.view

import androidx.fragment.app.DialogFragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import com.core.base.NavigationCommand
import com.example.login.R
import com.example.login.databinding.ReauthenticationDialogBinding
import com.example.login.presentation.viewmodel.ReauthenticationViewModel
import kotlinx.coroutines.launch

class ReauthenticationDialog : DialogFragment(R.layout.reauthentication_dialog) {
    private val args: ReauthenticationDialogArgs by navArgs()
    private val viewModel: ReauthenticationViewModel by viewModels()
    private val viewBinding: ReauthenticationDialogBinding by lazy {
        ReauthenticationDialogBinding.bind(requireView())
    }

    override fun onStart() {
        super.onStart()
        lifecycleScope.launch {
            viewModel.launch(args)

            viewModel.onActionCompleted.collect { command: NavigationCommand ->
                //TODO: verify
                val navController = findNavController()
                when (command) {
                    is NavigationCommand.To ->
                        navController.navigate(command.directions)
                    NavigationCommand.Back ->
                        navController.popBackStack()
                    is NavigationCommand.BackTo ->
                        navController.popBackStack(command.destinationId, false)
                    NavigationCommand.ToRoot ->
                        navController.popBackStack(navController.graph.startDestinationId, false)
                }
                dismiss()
            }
        }
        viewBinding.also {
            // TODO unnecessary setOnClickListener can be set via data binding
            it.btnLogin.setOnClickListener { viewModel.onLoginClicked() }
        }
    }
}