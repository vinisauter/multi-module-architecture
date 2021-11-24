package com.example.login

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController

class LoginFragment : Fragment() {

    private val loginViewUseCaseInterface = LoginBusinessModel(LoginRepository())

    private val loginViewModel = LoginViewModel(loginViewUseCaseInterface)

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?)
            : View? {

        return inflater.inflate(R.layout.fragment_login, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        view.findViewById<TextView>(R.id.to_profile).setOnClickListener {
            findNavController().navigate(R.id.profile_graph)
        }
        view.findViewById<TextView>(R.id.to_home).setOnClickListener {
            findNavController().navigate(R.id.home_graph)
        }
        view.findViewById<TextView>(R.id.show_login).setOnClickListener {
            loginViewModel.login()
        }
    }
}