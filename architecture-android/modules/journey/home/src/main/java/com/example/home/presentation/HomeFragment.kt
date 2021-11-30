package com.example.home.presentation

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.core.extensions.navigate
import com.example.app.R
import com.example.home.databinding.FragmentHomeBinding

class HomeFragment : Fragment() {
    lateinit var binding: FragmentHomeBinding
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentHomeBinding.inflate(inflater, container, false).also {
//            it.profileButton.setOnClickListener { navigate(HomeFragmentDirections.actionLaunchProfile()) }
            it.exitButton.setOnClickListener {
                navigate(
                    HomeFragmentDirections.actionDidFinish(
                        destination = resources.getString(R.string.route_splash)
                    )
                )
            }
        }
        return binding.root
    }
}