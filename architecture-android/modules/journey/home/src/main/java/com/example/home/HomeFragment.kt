package com.example.home

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.home.databinding.FragmentHomeBinding
import com.navigationapp.ActionsGlobal
import com.navigationapp.NavigatorController

class HomeFragment : Fragment() {

    private var navigatior: NavigatorController? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val binding =  FragmentHomeBinding.bind(view)
        navigatior = NavigatorController(this)

        binding.apply {
            buttonProfile.setOnClickListener { view ->
                goToProfileGraph()
            }
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        return FragmentHomeBinding.inflate(inflater, container, false).root
    }

    private fun goToProfileGraph() {
        navigatior?.navigate(ActionsGlobal.PROFILE_GRAPH.value())
    }


}