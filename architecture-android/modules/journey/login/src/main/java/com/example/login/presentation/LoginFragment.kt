package com.example.login.presentation

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavDirections
import com.core.extensions.navigate
import com.example.login.R
import com.example.login.databinding.FragmentLoginBinding
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class LoginFragment : Fragment(R.layout.fragment_login) {
    private val viewModel: LoginFragmentViewModel by viewModels()
    private val viewBinding: FragmentLoginBinding by lazy {
        FragmentLoginBinding.bind(requireView())
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewBinding.also {
            // TODO setOnClickListener via xml
            it.loginButton.setOnClickListener { viewModel.onLoginClicked() }
            it.forgotPasswordButton.setOnClickListener { viewModel.onForgotPasswordClicked() }
        }
        lifecycleScope.launch {
            viewModel.onActionCompleted().collect { navDirection: NavDirections ->
                navigate(navDirection)
            }
        }

    }
}