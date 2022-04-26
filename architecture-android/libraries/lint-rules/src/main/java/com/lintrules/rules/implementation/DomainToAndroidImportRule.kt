package com.lintrules.rules.implementation

import com.lintrules.rules.contract.InvalidImportRule

class DomainToAndroidImportRule : InvalidImportRule {
    override fun isAllowedImport(visitingPackage: String, importStatement: String) =
            !(isDomainPackage(visitingPackage)
                    && isAndroidImport(importStatement))

    private fun isDomainPackage(visitingPackage: String) =
            visitingPackage.contains(".domain.")
                    || visitingPackage.endsWith("domain")

    private fun isAndroidImport(importStatement: String) = importStatement.contains("android")

    override fun getMessage() = "No android dependency is allowed. Domain is platform independent. "
}