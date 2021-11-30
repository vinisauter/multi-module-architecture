package com.example.home.presentation

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import com.core.extensions.navigate
import com.example.home.databinding.FragmentHomeBinding

class HomeFragment : Fragment() {
    lateinit var binding: FragmentHomeBinding
    private val viewModel: HomeViewModel by viewModels()
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentHomeBinding.inflate(inflater, container, false)
        viewModel.profileButton.observe(this){
            navigate(HomeFragmentDirections.actionLaunchProfile())
        }
        viewModel.exitButton.observe(this){
            navigate(HomeFragmentDirections.actionExit())
        }
        return binding.root
    }
}