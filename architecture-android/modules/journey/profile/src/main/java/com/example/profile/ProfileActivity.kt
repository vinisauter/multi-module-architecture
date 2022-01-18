package com.example.profile

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.example.flutter.FlutterEngineExecutor

class ProfileActivity : AppCompatActivity(), ProfileDataModelObserver {

    private lateinit var countView: TextView
    private val mainActivityIdentifier: Int = mainActivityCount

    private companion object {
        var mainActivityCount = 0
    }

    init {
        mainActivityCount += 1
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_profile)

        FlutterEngineExecutor.start(this)

        supportActionBar?.title = "Perfil e configurações"

        ProfileDataModel.instance.addObserver(this)
        countView = findViewById(R.id.count)
        countView.text = ProfileDataModel.instance.counter.toString()
    }

    override fun onDestroy() {
        super.onDestroy()
        ProfileDataModel.instance.removeObserver(this)

        FlutterEngineExecutor.stop()
    }

    fun onClickNext(view: View) {
        val nextClass =
            if (mainActivityIdentifier % 2 == 0) ProfileSingleFlutterActivity::class.java else ProfileDoubleFlutterActivity::class.java
        val flutterIntent = Intent(this, nextClass)
        startActivity(flutterIntent)
    }

    fun onClickAdd(view: View) {
        ProfileDataModel.instance.counter += 1
    }

    override fun onCountUpdate(newCount: Int) {
        countView.text = newCount.toString()
    }
}
