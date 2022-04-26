package com.lintrules.rules.implementation

import com.lintrules.rules.contract.InvalidImportRule

class DataToPresentationImportRule : InvalidImportRule {
    override fun isAllowedImport(visitingPackage: String, importStatement: String) =
            !(isDataPackage(visitingPackage)
                    && isPresentationImport(importStatement))

    private fun isPresentationImport(importStatement: String) =
            importStatement.contains(".presentation.")
                    || importStatement.endsWith("presentation")

    private fun isDataPackage(visitingPackage: String) =
            visitingPackage.contains(".data.")
                    || visitingPackage.endsWith("data")

    override fun getMessage() = "Data classes should not import from presentation package"
}