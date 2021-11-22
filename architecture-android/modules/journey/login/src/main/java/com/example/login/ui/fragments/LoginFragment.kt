package com.example.login.ui.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.fragment.app.Fragment
import com.example.login.R
import com.example.login.ui.locator.AppServiceLocator
import com.navigationapp.ActionsGlobal
import com.navigationapp.NavigatorController

class LoginFragment : Fragment() {

    private var navigatior: NavigatorController? = null
    private var loginViewModel: LoginViewModel? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        navigatior = NavigatorController(this)
        initViewModels()
        val buttonHome = view.findViewById<Button>(R.id.buttonHome)
        buttonHome.setOnClickListener {
             loginViewModel?.requestSignIn("sanzjv", "123")?.let {
                 if (it) goToHomeGraph()
             }
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_login, container, false)
    }

    private fun goToHomeGraph() {
        navigatior?.navigate(ActionsGlobal.HOME_GRAPH.value())
    }

    private fun initViewModels() {
        val presenterLocator: LoginViewModelLocator =
            AppServiceLocator.instance.plusActivityServiceLocator()
        loginViewModel = presenterLocator.loginViewModel(this)
    }

}