package com.example.structural.tagging

import android.app.Application
import com.auto.service.ImplementationOf
import com.example.tagging.TaggingExecutor

@ImplementationOf(TaggingProvider::class)
class TaggingProviderImpl : TaggingProvider {
    override fun executor(app: Application): TaggingExecutor {
        return TaggingExecutorImpl(app)
    }
}
