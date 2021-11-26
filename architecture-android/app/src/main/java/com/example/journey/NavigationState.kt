package com.example.journey

import android.os.Parcelable
import kotlinx.parcelize.Parcelize

@Parcelize
data class NavigationState(
    val from: String,//TODO: ENUM?
    val state: String,//TODO: ENUM?
) : Parcelable