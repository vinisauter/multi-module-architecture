package com.example.home.presentation

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.injectViewModel
import androidx.navigation.NavDirections
import com.core.extensions.consume
import com.core.extensions.navigate
import com.example.home.databinding.FragmentHomeBinding

class HomeFragment : Fragment() {
    private lateinit var binding: FragmentHomeBinding
    private val viewModel: HomeFragmentViewModel by injectViewModel()
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentHomeBinding.inflate(inflater, container, false).also {
            it.profileButton.setOnClickListener { viewModel.onProfileClicked() }
            it.exitButton.setOnClickListener { viewModel.onExitClicked() }
        }
        consume(viewModel.onActionCompleted) { navDirection: NavDirections ->
            navigate(navDirection)
        }
        return binding.root
    }
}