package com.lintrules.rules.implementation

import com.lintrules.rules.contract.InvalidImportRule

class PresentationToDataImportRule : InvalidImportRule {
    override fun isAllowedImport(visitingPackage: String, importStatement: String) =
            !(isPresentationPackage(visitingPackage)
                    && isDataPackage(importStatement))

    private fun isDataPackage(importStatement: String) =
            importStatement.contains(".data.")
                    || importStatement.endsWith("data")

    private fun isPresentationPackage(visitingPackage: String) =
            visitingPackage.contains(".presentation.")
                    || visitingPackage.endsWith("presentation")

    override fun getMessage() = "Presentation classes should not import from data package"
}