package com.example.home

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.example.flutter.FlutterEngineExecutor

class HomeActivity : AppCompatActivity(), HomeDataModelObserver {

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
        setContentView(R.layout.activity_home)

        FlutterEngineExecutor.start(this)

        supportActionBar?.title = "Home"

        HomeDataModel.instance.addObserver(this)
        countView = findViewById(R.id.count)
        countView.text = HomeDataModel.instance.counter.toString()
    }

    override fun onDestroy() {
        super.onDestroy()
        HomeDataModel.instance.removeObserver(this)

        FlutterEngineExecutor.stop()
    }

    fun onClickNext(view: View) {
        val nextClass =
            if (mainActivityIdentifier % 2 == 0) HomeSingleFlutterActivity::class.java else HomeDoubleFlutterActivity::class.java
        val flutterIntent = Intent(this, nextClass)
        startActivity(flutterIntent)
    }

    fun onClickAdd(view: View) {
        HomeDataModel.instance.counter += 1
    }

    override fun onCountUpdate(newCount: Int) {
        countView.text = newCount.toString()
    }
}
