package com.example.login.presentation

import androidx.lifecycle.injectViewModel
import androidx.navigation.NavDirections
import com.core.base.BaseFragment
import com.core.base.LoaderDialog
import com.core.extensions.State
import com.core.extensions.consume
import com.core.extensions.navigate
import com.example.login.databinding.FragmentLoginBinding

class LoginFragment : BaseFragment<FragmentLoginBinding, LoginFragmentViewModel>() {
    override val viewModel: LoginFragmentViewModel by injectViewModel()

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