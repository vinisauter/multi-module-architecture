package com.example.app

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.navigation.fragment.findNavController

class MainFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?)
    : View? {

        return inflater.inflate(R.layout.fragment_main, container, false).also {
            val text = it.findViewById<TextView>(R.id.main_button)
            text.setOnClickListener {
                findNavController().navigate(MainFragmentDirections.button())
            }
        }
    }

    companion object {
        @JvmStatic
        fun newInstance(param1: String, param2: String) = MainFragment()
    }
}