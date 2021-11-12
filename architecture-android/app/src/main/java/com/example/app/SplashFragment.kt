package com.example.app

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.IdRes
import androidx.lifecycle.Observer
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavOptions
import androidx.navigation.dynamicfeatures.DynamicExtras
import androidx.navigation.dynamicfeatures.DynamicInstallMonitor
import androidx.navigation.findNavController
import androidx.navigation.fragment.findNavController
import com.example.app.databinding.FragmentSplashBinding
import com.google.android.play.core.splitinstall.SplitInstallManager
import com.google.android.play.core.splitinstall.SplitInstallSessionState
import com.google.android.play.core.splitinstall.model.SplitInstallSessionStatus
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class SplashFragment : Fragment() {

    private var _binding: FragmentSplashBinding? = null
    private val binding get() = _binding!!

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentSplashBinding.inflate(inflater, container, false)
        val navController = findNavController()
        binding.buttonContinue.setOnClickListener {
            navigate(R.id.action_splashFragment_to_login)
        }
//        lifecycleScope.launch{
//            delay(500L)
//            navController.navigate(R.id.action_splashFragment_to_login)
//        }
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