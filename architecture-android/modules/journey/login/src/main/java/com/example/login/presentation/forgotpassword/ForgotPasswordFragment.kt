package com.example.login.presentation.forgotpassword

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavDirections
import com.core.base.BaseHostActivity
import com.core.base.BaseViewModelFactory
import com.core.extensions.navigate
import com.example.login.R
import com.example.login.databinding.FragmentForgotPasswordBinding
import kotlinx.coroutines.launch

class ForgotPasswordFragment : Fragment(R.layout.fragment_forgot_password) {
    private val viewModel: ForgotPasswordFragmentViewModel by viewModels {
        BaseViewModelFactory(
            application = requireActivity().application,
            savedStateRegistryOwner = this,
            defaultArgs = arguments,
            provider = (requireActivity() as BaseHostActivity<*>).getDependencyProvider()
        )
    }
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