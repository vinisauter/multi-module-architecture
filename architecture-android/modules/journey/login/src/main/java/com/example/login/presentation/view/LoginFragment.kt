package com.example.login.presentation.view

import androidx.lifecycle.injectViewModel
import androidx.navigation.NavDirections
import com.core.base.BaseFragment
import com.core.base.LoaderDialog
import com.core.extensions.State
import com.core.extensions.consume
import com.core.extensions.navigate
import com.example.login.databinding.FragmentLoginBinding
import com.example.login.presentation.viewmodel.LoginViewModel

class LoginFragment : BaseFragment<FragmentLoginBinding, LoginViewModel>() {
    override val viewModel: LoginViewModel by injectViewModel()

    override fun afterViews(binding: FragmentLoginBinding) {
        viewModel.onLoginViewCreated()
        binding.viewModel = viewModel
        consume(viewModel.onActionCompleted) { navDirection: NavDirections ->
            navigate(navDirection)
        }
        consume(viewModel.onStateChanged) { state: State ->
            when (state) {
                State.Running -> showLoading()
                State.Idle -> hideLoading()
            }
        }
    }

    private fun hideLoading() {
        loader?.dismiss()
        loader = null
    }

    var loader: LoaderDialog? = null
    private fun showLoading() {
        if (loader == null) loader = LoaderDialog().also {
            it.show(childFragmentManager, "login-loader")
        }
    }
}