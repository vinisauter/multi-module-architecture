package com.example.dynamicfeature

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

class DynamicFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_dynamic, container, false)
    }

    companion object {
        @JvmStatic
        fun newInstance(param1: String, param2: String) = DynamicFragment()
    }
}