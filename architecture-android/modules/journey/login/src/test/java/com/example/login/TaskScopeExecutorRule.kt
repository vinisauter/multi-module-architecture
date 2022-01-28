package com.example.login

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.launch
import kotlinx.coroutines.test.TestCoroutineScope
import kotlinx.coroutines.test.TestScope
import org.junit.runner.Description
import kotlin.coroutines.CoroutineContext
import kotlin.coroutines.EmptyCoroutineContext

/**
 * Sets the main coroutines dispatcher to a [TestCoroutineScope] for unit testing. A
 * [TestCoroutineScope] provides control over the execution of coroutines.
 *
 * Declare it as a JUnit Rule:
 *
 * ```
 * @get:Rule
 * var mainCoroutineRule = MainCoroutineRule()
 * ```
 *
 * Use it directly as a [TestCoroutineScope]:
 *
 * ```
 * mainCoroutineRule.pauseDispatcher()
 * ...
 * mainCoroutineRule.resumeDispatcher()
 * ...
 * mainCoroutineRule.runBlockingTest { }
 * ...
 *
 * ```
 */
class TaskScopeExecutorRule(
    val context: CoroutineContext = EmptyCoroutineContext,
    val scope: TestScope = TestScope(context),
) : InstantTaskExecutorRule() {

    //        val dispatcher: TestCoroutineDispatcher = TestCoroutineDispatcher()
    override fun starting(description: Description?) {
        super.starting(description)
//        Dispatchers.setMain(dispatcher)
    }

    override fun finished(description: Description?) {
        super.finished(description)
//        Dispatchers.resetMain()
//        dispatcher.cleanupTestCoroutines()
    }

    fun launchTest(
        context: CoroutineContext = EmptyCoroutineContext,
        start: CoroutineStart = CoroutineStart.DEFAULT,
        block: suspend CoroutineScope.() -> Unit
    ) {
        scope.launch(context, start, block)
    }
}
