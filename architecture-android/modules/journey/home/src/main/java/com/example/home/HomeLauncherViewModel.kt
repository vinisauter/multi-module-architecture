package com.example.home

import android.app.Application
import android.net.Uri
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavDirections
import com.core.extensions.onCpu
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class HomeLauncherViewModel(application: Application) : AndroidViewModel(application) {
    private val onActionCompletedSharedFlow = MutableSharedFlow<NavDirections>()
    val onActionCompleted: Flow<NavDirections>
        get() = onActionCompletedSharedFlow

    fun launch(deepLink: Uri?, args: HomeLauncherDialogArgs) = viewModelScope.onCpu {
        //TODO: Validate args & DeepLink and Directions
        onActionCompletedSharedFlow.emit(
            HomeLauncherDialogDirections.actionToHome()
        )
    }
}
