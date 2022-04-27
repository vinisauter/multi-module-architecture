package com.example.login.presentation.view

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import androidx.lifecycle.injectViewModel
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavDirections
import com.core.extensions.navigate
import com.example.login.presentation.viewmodel.ForgotPasswordViewModel
import com.example.login.R
import com.example.login.databinding.FragmentForgotPasswordBinding
import kotlinx.coroutines.launch

class ForgotPasswordFragment : Fragment(R.layout.fragment_forgot_password) {
    private val viewModel: ForgotPasswordViewModel by injectViewModel()
    private val binding: FragmentForgotPasswordBinding by lazy {
        FragmentForgotPasswordBinding.bind(requireView())
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel.onForgotPasswordViewCreated()
        binding.also {
            it.exitButton.setOnClickListener {
                viewModel.onExitClicked()
            }
        }
        lifecycleScope.launch {
            viewModel.onActionCompleted.collect { navDirection: NavDirections ->
                navigate(navDirection)
            }
        }
    }
}