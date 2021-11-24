package com.example.app

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import com.example.app.databinding.FragmentMainBinding

class MainFragment : Fragment(R.layout.fragment_main) {
    private var viewBinding: FragmentMainBinding? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding = FragmentMainBinding.bind(view).also { binding: FragmentMainBinding ->
//            binding.loginButton.setOnClickListener { navigate(MainFragmentDirections.actionLogin()) }
//            binding.accessionButton.setOnClickListener { navigate(MainFragmentDirections.actionAccession()) }
//            binding.deepLinkButton.setOnClickListener { val link = binding.deepLinkEditText.text.toString().toUri() }
        }
    }

    override fun onDestroy() {
        viewBinding = null
        super.onDestroy()
    }
}
