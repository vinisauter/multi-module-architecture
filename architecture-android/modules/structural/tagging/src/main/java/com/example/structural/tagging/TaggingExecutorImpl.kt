package com.example.structural.tagging

import android.app.Application
import com.core.logger.Logger
import com.example.tagging.Tagging
import com.example.tagging.TaggingExecutor

class TaggingExecutorImpl(private val app: Application) : TaggingExecutor {
    override fun send(tagging: Tagging) = when (tagging) {
        is Tagging.ScreenName -> {
            Logger.log("Tagging { screenName: ${tagging.screenName} }")
        }
        is Tagging.Event -> {
            Logger.log("Tagging { sendEvent [ category: ${tagging.category}, action: ${tagging.action}, label: ${tagging.label} ] }")
        }
        Tagging.Ignore -> {
            Logger.log("Tagging { ignored }")
        }
    }
}
