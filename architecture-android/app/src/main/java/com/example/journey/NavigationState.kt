package com.example.journey

import android.os.Parcelable
import androidx.annotation.IdRes
import kotlinx.parcelize.Parcelize

@Parcelize
data class NavigationState(
    val from: String,//TODO: ENUM?
    val state: String,//TODO: ENUM?
    @IdRes val destination: Int,
) : Parcelable