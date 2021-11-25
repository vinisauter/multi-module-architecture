package com.example.login.presentation

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import androidx.lifecycle.injectViewModel
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavDirections
import com.core.extensions.navigate
import com.example.login.R
import com.example.login.databinding.FragmentLoginBinding
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class LoginFragment : Fragment(R.layout.fragment_login) {
    private val viewModel: LoginFragmentViewModel by injectViewModel()
    private val viewBinding: FragmentLoginBinding by lazy {
        FragmentLoginBinding.bind(requireView())
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel.onLoginViewCreated()
        // TODO: unnecessary setOnClickListener can be set via data binding
        viewBinding.viewModel = viewModel
        viewBinding.also {
            it.loginButton.setOnClickListener { viewModel.onLoginClicked() }
            it.forgotPasswordButton.setOnClickListener { viewModel.onForgotPasswordClicked() }
        }
        //TODO: show loading if needed
        lifecycleScope.launch {
            viewModel.onActionCompleted.collect { navDirection: NavDirections ->
                navigate(navDirection)
            }
        }
    }
}