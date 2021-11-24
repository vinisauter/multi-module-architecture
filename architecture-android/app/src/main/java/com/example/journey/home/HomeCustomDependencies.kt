package com.example.journey.home

import android.os.Parcelable
import com.core.extensions.Direction
import kotlinx.parcelize.Parcelize

// pass by value using Serializable or Parcelable
// pass by reference using AIDL (https://developer.android.com/guide/components/aidl?hl=pt-br)
@Parcelize
data class HomeCustomDependencies(
    var didFinishDirection: Direction? = null
) : Parcelable