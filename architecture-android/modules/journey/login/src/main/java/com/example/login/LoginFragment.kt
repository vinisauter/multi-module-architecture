package com.example.login

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.fragment.app.Fragment
import com.navigationapp.ActionsGlobal
import com.navigationapp.NavigatorController

class LoginFragment : Fragment() {

    private var navigatior: NavigatorController? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {

        navigatior = NavigatorController(this)

        val buttonHome = view.findViewById<Button>(R.id.buttonHome)

        buttonHome.setOnClickListener {
            goToHomeGraph()
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

}