package com.lintrules.rules.contract

interface InvalidImportRule {

    // Return true if allowed import, false if violation
    fun isAllowedImport(
            visitingPackage: String,
            importStatement: String) : Boolean

    // Message to show in case of not allowed import
    fun getMessage(): String
}