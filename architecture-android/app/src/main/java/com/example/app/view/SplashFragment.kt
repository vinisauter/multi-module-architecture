package com.example.app.view

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.IdRes
import androidx.navigation.NavOptions
import androidx.navigation.dynamicfeatures.DynamicExtras
import androidx.navigation.dynamicfeatures.DynamicInstallMonitor
import androidx.navigation.fragment.findNavController
import com.example.app.databinding.FragmentSplashBinding

class SplashFragment : Fragment() {

    private var _binding: FragmentSplashBinding? = null
    private val binding get() = _binding!!

    private val goLogin = SplashFragmentDirections.actionSplashFragmentToLogin().actionId

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentSplashBinding.inflate(inflater, container, false)
        binding.buttonContinue.setOnClickListener {
            navigate(goLogin)
        }
        return binding.root
    }

    fun Fragment.navigate(
        @IdRes destinationId: Int,
        args: Bundle? = null,
        navOptions: NavOptions? = null
    ) {
        val navController = findNavController()
        val installMonitor = DynamicInstallMonitor()
        val dynamicExtras = DynamicExtras(installMonitor)
        navController.navigate(destinationId, args, navOptions, dynamicExtras)
        //installMonitor.observe(viewLifecycleOwner, statusObserver)
    }
}