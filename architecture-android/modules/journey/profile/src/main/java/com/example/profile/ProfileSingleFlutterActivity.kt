package com.example.profile

import android.content.Intent
import com.example.flutter.BaseBindings
import com.example.home.BaseFlutterActivity

class ProfileSingleFlutterActivity : BaseFlutterActivity(), ProfileBindingsDelegate {
    private val singleBindings: ProfileBindings by lazy {
        ProfileBindings(context = this, delegate = this, entrypoint = "profileSingleRoute")
    }

    override fun getSingleBindings(): BaseBindings {
        return singleBindings
    }

    override fun onNext() {
        val flutterIntent = Intent(this, ProfileActivity::class.java)
        startActivity(flutterIntent)
    }
}
