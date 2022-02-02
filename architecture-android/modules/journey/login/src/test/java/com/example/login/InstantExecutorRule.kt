package com.example.login

import androidx.arch.core.executor.ArchTaskExecutor
import androidx.arch.core.executor.TaskExecutor
import com.core.extensions.DefaultDispatcherProvider
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.TestScope
import kotlinx.coroutines.test.UnconfinedTestDispatcher
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.setMain
import org.junit.rules.TestWatcher
import org.junit.runner.Description

class InstantExecutorRule : TestWatcher() {
    val testDispatcher by lazy { UnconfinedTestDispatcher() }
    val testScope by lazy { TestScope(testDispatcher) }

    override fun starting(description: Description?) {
        DefaultDispatcherProvider.apply {
            Main = testDispatcher
            Default = testDispatcher
            IO = testDispatcher
            Unconfined = testDispatcher
        }
        Dispatchers.setMain(testDispatcher)
        ArchTaskExecutor.getInstance().setDelegate(object : TaskExecutor() {
            override fun executeOnDiskIO(runnable: Runnable) {
                runnable.run()
            }

            override fun postToMainThread(runnable: Runnable) {
                runnable.run()
            }

            override fun isMainThread(): Boolean {
                return true
            }
        })
    }

    override fun finished(description: Description?) {
        ArchTaskExecutor.getInstance().setDelegate(null)
        Dispatchers.resetMain()
    }
}