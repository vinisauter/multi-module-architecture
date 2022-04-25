package com.example.forgotpassword.presentation.view

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import androidx.lifecycle.injectViewModel
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavDirections
import com.core.extensions.navigate
import com.example.forgotpassword.presentation.viewmodel.ForgotPasswordFragmentViewModel
import com.example.login.R
import com.example.login.databinding.FragmentForgotPasswordBinding
import kotlinx.coroutines.launch

class ForgotPasswordFragment : Fragment(R.layout.fragment_forgot_password) {
    private val viewModel: ForgotPasswordFragmentViewModel by injectViewModel()
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