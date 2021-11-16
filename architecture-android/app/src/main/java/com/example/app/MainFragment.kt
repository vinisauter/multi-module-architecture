package com.example.app

import android.os.Bundle
import android.view.View
import androidx.core.net.toUri
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.core.extensions.navigate
import com.example.app.databinding.FragmentMainBinding

class MainFragment : Fragment(R.layout.fragment_main) {
    private var viewBinding: FragmentMainBinding? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding = FragmentMainBinding.bind(view).also { binding: FragmentMainBinding ->
            binding.loginButton.setOnClickListener { navigate(MainFragmentDirections.actionLogin()) }
            binding.accessionButton.setOnClickListener { navigate(MainFragmentDirections.actionAccession()) }
            binding.deepLinkButton.setOnClickListener {
                val deepLink = binding.deepLinkEditText.text.toString().toUri()
                findNavController().navigate(deepLink)
            }
        }
    }

    override fun onDestroy() {
        viewBinding = null
        super.onDestroy()
    }
}
