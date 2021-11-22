package com.example.profile

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.profile.databinding.FragmentProfileBinding
import com.navigationapp.ActionsGlobal
import com.navigationapp.NavigatorController

class ProfileFragment : Fragment() {

    //private val args: ProfileFragmentArgs by navArgs()
    private var navigatior: NavigatorController? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val binding = FragmentProfileBinding.bind(view)
        navigatior = NavigatorController(this)

        binding.apply {
            buttonClose.setOnClickListener { view ->
                goToHomeGraph()
            }
        }
        /*args.texto?.let {
            binding.textView.text = it
        }*/
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_profile, container, false)
    }

    private fun goToHomeGraph() {
        navigatior?.navigate(ActionsGlobal.HOME_GRAPH.value())
    }

}