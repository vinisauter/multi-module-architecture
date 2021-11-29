package com.navigationapp

import android.content.Context
import android.content.Intent

object Actions {
    fun openLoginIntent(context: Context) = internalIntent(context, "com.example.login.open")
    fun openHomeIntent(context: Context) = internalIntent(context, "com.example.home.open")
    fun openProfileIntent(context: Context) = internalIntent(context, "com.example.profile.open")

    /*fun openDashboardIntent(context: Context, userId: String) = internalIntent(context, "com.modularization.dashboard.open")
            .putExtra(EXTRA_USER, UserArgs(userId))*/
    fun openSharingIntent(context: Context) =
        internalIntent(context, "com.modularization.sharing.open")

    private fun internalIntent(context: Context, action: String) =
        Intent(action).setPackage(context.packageName)
}