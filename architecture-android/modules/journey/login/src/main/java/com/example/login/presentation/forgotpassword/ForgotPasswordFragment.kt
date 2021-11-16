package com.example.login.presentation.forgotpassword

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import com.core.extensions.navigate
import com.example.login.R
import com.example.login.databinding.FragmentForgotPasswordBinding

class ForgotPasswordFragment : Fragment(R.layout.fragment_forgot_password) {
    private val binding: FragmentForgotPasswordBinding by lazy {
        FragmentForgotPasswordBinding.bind(requireView())
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.also {
            it.exitButton.setOnClickListener { navigate(ForgotPasswordFragmentDirections.actionExit()) }
        }
    }
}