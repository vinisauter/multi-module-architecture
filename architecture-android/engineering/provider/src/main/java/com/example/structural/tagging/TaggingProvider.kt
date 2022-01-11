package com.example.structural.tagging

import android.app.Application
import com.example.tagging.TaggingExecutor

interface TaggingProvider {
    fun executor(app: Application): TaggingExecutor
}
