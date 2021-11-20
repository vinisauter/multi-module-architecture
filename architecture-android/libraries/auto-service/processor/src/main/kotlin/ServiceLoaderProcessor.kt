import com.auto.service.ImplementationOf
import com.google.devtools.ksp.getClassDeclarationByName
import com.google.devtools.ksp.processing.*
import com.google.devtools.ksp.symbol.*
import com.google.devtools.ksp.validate

class ServiceLoaderProcessorProvider : SymbolProcessorProvider {
    override fun create(
        environment: SymbolProcessorEnvironment,
    ): SymbolProcessor {
        return ServiceLoaderProcessor(environment)
    }
}

class ServiceLoaderProcessor(
    environment: SymbolProcessorEnvironment,
) : SymbolProcessor {
    private val codeGenerator = environment.codeGenerator
    private val logger = environment.logger

    override fun process(resolver: Resolver): List<KSAnnotated> {
        resolver.getSymbolsWithAnnotation(ImplementationOf::class.java.name)
            .filter { it is KSClassDeclaration && it.validate() }
            .forEach { it.accept(ImplClassVisitor(resolver), Unit) }
        return emptyList()
    }

    inner class ImplClassVisitor(private val resolver: Resolver) : KSVisitorVoid() {
        override fun visitClassDeclaration(classDeclaration: KSClassDeclaration, data: Unit) {
            classDeclaration.primaryConstructor!!.accept(this, data)

            val classPackageName = classDeclaration.containingFile!!.packageName.asString()
            val classSimpleName = classDeclaration.simpleName.asString()
            val implClassQualifiedName = "$classPackageName.$classSimpleName"

            val impl: KSAnnotation = classDeclaration.getAnnotations(ImplementationOf::class).first()
            val argument = impl.arguments.first()
            val result = argument.value as KSType
            val interfaceQualifiedName = result.declaration.qualifiedName!!.asString()
            resolver.getClassDeclarationByName(interfaceQualifiedName)
            val fileServices = codeGenerator.createNewFile(
                Dependencies(true, classDeclaration.containingFile!!),
                "META-INF.services",
                interfaceQualifiedName,
                ""
            )
            fileServices.appendLn(implClassQualifiedName)
        }
    }
}


