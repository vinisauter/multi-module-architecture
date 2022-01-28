package com.example.task

import android.injection.Module
import android.os.Bundle
import com.core.base.ModuleControllerActivity

class TaskControllerActivity : ModuleControllerActivity(R.navigation.task_navigation_graph) {
    override fun Module.dependencies() {}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO ADD MODULES DEPENDENCIES
    }

    override fun onDestroy() {
        super.onDestroy()
        // TODO REMOVE MODULES DEPENDENCIES
    }
}
