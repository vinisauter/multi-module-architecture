package com.example.login.view

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.FragmentExtensions.consume
import androidx.fragment.app.viewModels
import com.example.app.view.HomeFragment
import com.example.login.databinding.FragmentLoginBinding
import com.example.login.viewmodel.LoginViewModel

/**
 * A simple [Fragment] subclass as the default destination in the navigation.
 */
class LoginFragment : HomeFragment() {
    private val viewModel: LoginViewModel by viewModels()
    private lateinit var binding: FragmentLoginBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentLoginBinding.inflate(inflater, container, false)
        binding.viewModel = viewModel
        return binding.root

    }

    override fun onStart() {
        super.onStart()
        consume(viewModel.btLogin) { data ->
            if (data) {
                Log.w("PRESSED", "loginButton")
            }
        }
    }

    override fun execute() {}
}