package com.example.journey.login

import android.os.Parcelable
import com.core.extensions.Direction
import com.example.journey.login.tracking.LoginTracking
import kotlinx.parcelize.Parcelize

// pass by value using Serializable or Parcelable
// pass by reference using AIDL (https://developer.android.com/guide/components/aidl?hl=pt-br)
@Parcelize
data class LoginCustomDependencies(
    var tracking: LoginTracking? = null,
    var didFinishDirection: Direction? = null
) : Parcelable