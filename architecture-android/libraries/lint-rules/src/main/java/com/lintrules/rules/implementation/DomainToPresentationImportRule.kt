package com.lintrules.rules.implementation

import com.lintrules.rules.contract.InvalidImportRule

class DomainToPresentationImportRule : InvalidImportRule {
    override fun isAllowedImport(visitingPackage: String, importStatement: String) =
            !(isDomainPackage(visitingPackage)
                    && isDataPackage(importStatement))

    private fun isDataPackage(importStatement: String) =
            importStatement.contains(".presentation.")
                    || importStatement.endsWith("presentation")

    private fun isDomainPackage(visitingPackage: String) =
            visitingPackage.contains(".domain.")
                    || visitingPackage.endsWith("domain")

    override fun getMessage() = "Domain classes should not import from presentation package"
}