package com.example.login.presentation

import androidx.fragment.app.viewModels
import com.core.base.BaseFragment
import com.core.base.LoaderDialog
import com.core.extensions.State
import com.core.extensions.navigate
import com.example.login.databinding.FragmentLoginBinding

class LoginFragment :
    BaseFragment<FragmentLoginBinding, LoginFragmentEvent, LoginFragmentEffect, LoginFragmentViewModel>() {
    override val viewModel: LoginFragmentViewModel by viewModels()

    override fun afterViews(binding: FragmentLoginBinding) {
        viewModel.processEvent(LoginFragmentEvent.OnScreenLoad)
        binding.forgotPasswordButton.setOnClickListener {
            viewModel.processEvent(LoginFragmentEvent.OnForgotPassword)
        }
        binding.loginButton.setOnClickListener {
            viewModel.processEvent(LoginFragmentEvent.OnLogin)
        }
    }

    override fun processEffect(effect: LoginFragmentEffect) {
        // TODO: make effect for each direction? or keep direction from xml?
        when (effect) {
            LoginFragmentEffect.Exit -> navigate(LoginFragmentDirections.actionExit())
            is LoginFragmentEffect.Direction -> navigate(effect.direction)
        }
    }

    var loader: LoaderDialog? = null
    override fun processState(state: State) {
        binding.loginButton.isEnabled = state == State.Idle
        binding.forgotPasswordButton.isEnabled = state == State.Idle
        when (state) {
            State.Running -> {
                if (loader == null) loader = LoaderDialog().also {
                    it.show(childFragmentManager, "login-loader")
                }
            }
            State.Idle -> {
                loader?.dismiss()
                loader = null
            }
        }
    }
}