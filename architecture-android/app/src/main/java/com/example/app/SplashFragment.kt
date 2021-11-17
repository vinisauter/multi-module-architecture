package com.example.app

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.app.databinding.SplashFragmentBinding
import com.navigationapp.ActionsGlobal
import com.navigationapp.NavigatorController

class SplashFragment : Fragment() {

    private var navigatior: NavigatorController? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val binding = SplashFragmentBinding.bind(view)
        navigatior = NavigatorController(this)

        binding.apply {
            buttonLogin.setOnClickListener {
                goToLoginGraph()
            }
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        return SplashFragmentBinding.inflate(inflater, container, false).root
    }

    private fun goToLoginGraph() {
        navigatior?.navigate(ActionsGlobal.LOGIN_GRAPH.value())
    }
}
