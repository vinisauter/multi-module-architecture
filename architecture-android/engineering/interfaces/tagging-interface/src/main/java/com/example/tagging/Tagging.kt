package com.example.tagging

import android.os.Parcelable
import kotlinx.parcelize.Parcelize

sealed class Tagging : Parcelable {
    @Parcelize
    data class ScreenName(val screenName: String) : Tagging()

    @Parcelize
    data class Event(val category: String, val action: String, val label: String) : Tagging()

    @Parcelize
    object Ignore : Tagging()
}