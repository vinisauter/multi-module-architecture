package com.example.login.presentation.reauthentication

import androidx.fragment.app.DialogFragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavDirections
import androidx.navigation.fragment.navArgs
import com.core.extensions.navigate
import com.example.login.R
import com.example.login.databinding.ReauthenticationDialogBinding
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class ReauthenticationDialog : DialogFragment(R.layout.reauthentication_dialog) {
    private val args: ReauthenticationDialogArgs by navArgs()
    private val viewModel: ReauthenticationDialogViewModel by viewModels()
    private val viewBinding: ReauthenticationDialogBinding by lazy {
        ReauthenticationDialogBinding.bind(requireView())
    }

    override fun onStart() {
        super.onStart()
        lifecycleScope.launch {
            viewModel.launch(args)

            viewModel.onActionCompleted.collect { navDirection: NavDirections ->
                navigate(navDirection)
            }
        }
        viewBinding.also {
            // TODO unnecessary setOnClickListener can be set via data binding
            it.btnLogin.setOnClickListener { viewModel.onLoginClicked() }
        }
    }
}