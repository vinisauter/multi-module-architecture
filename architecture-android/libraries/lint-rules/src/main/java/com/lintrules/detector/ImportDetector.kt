package com.lintrules.detector

import com.android.tools.lint.client.api.UElementHandler
import com.android.tools.lint.detector.api.*
import com.lintrules.rules.implementation.*
import org.jetbrains.uast.UImportStatement
import org.jetbrains.uast.getContainingUFile
import java.util.*

class ImportDetector : Detector(), Detector.UastScanner {
    companion object {
        private const val MESSAGE = "Custom Lint Detector"

        val ISSUE = Issue.create(
                id = "IncorrectImportDetector",
                briefDescription = MESSAGE,
                explanation = MESSAGE,
                category = Category.CORRECTNESS,
                priority = 9,
                severity = Severity.ERROR,
                implementation = Implementation(
                        ImportDetector::class.java,
                        EnumSet.of(Scope.JAVA_FILE))
        )
    }

    val rules = listOf(
            DomainToAndroidImportRule(),
            DomainToDataImportRule(),
            DomainToPresentationImportRule(),
            PresentationToDataImportRule(),
            DataToPresentationImportRule()
    )

    override fun getApplicableUastTypes() = listOf(UImportStatement::class.java)

    override fun createUastHandler(context: JavaContext): UElementHandler? {
        return object : UElementHandler() {
            override fun visitImportStatement(node: UImportStatement) {
                node.importReference?.let { import ->
                    rules.forEach { rule ->
                        val visitingPackageName = import.getContainingUFile()?.packageName
                        val importedClass = import.asRenderString()
                        visitingPackageName?.let {
                            if (!rule.isAllowedImport(
                                            visitingPackageName,
                                            importedClass)) {

                                context.report(
                                        ISSUE,
                                        node,
                                        context.getLocation(import),
                                        rule.getMessage())
                            }
                        }
                    }
                }
            }
        }
    }
}