package com.example.home

import android.content.Intent
import com.example.flutter.BaseBindings
import com.example.flutter.BaseFlutterActivity

class HomeSingleFlutterActivity : BaseFlutterActivity(), HomeBindingsDelegate {
    private val singleBindings: HomeBindings by lazy {
        HomeBindings(context = this, delegate = this, entrypoint = "homeSingleRoute")
    }

    override fun getSingleBindings(): BaseBindings {
        return singleBindings
    }

    override fun onNext() {
        val flutterIntent = Intent(this, HomeActivity::class.java)
        startActivity(flutterIntent)
    }
}
