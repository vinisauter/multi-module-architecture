package com.core.analytics

import android.os.Parcelable
import kotlinx.parcelize.Parcelize

@Parcelize
data class Event(
    val category: String,
    val action: String,
    val label: String,
) : Parcelable