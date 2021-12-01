package com.example.login.presentation

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import androidx.lifecycle.injectViewModel
import androidx.navigation.NavDirections
import com.core.base.LoaderDialog
import com.core.extensions.State
import com.core.extensions.consume
import com.core.extensions.navigate
import com.example.login.R
import com.example.login.databinding.FragmentLoginBinding

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
        consume(viewModel.onActionCompleted) { navDirection: NavDirections ->
            navigate(navDirection)
        }
        consume(viewModel.onStateChanged) { state: State ->
            when (state) {// TODO: handle case of multiple states running at same time
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