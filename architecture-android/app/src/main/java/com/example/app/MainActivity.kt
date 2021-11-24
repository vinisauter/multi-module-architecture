package com.example.app

import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity(R.layout.activity_main) {
    val deepLink by lazy { intent.data }
}
