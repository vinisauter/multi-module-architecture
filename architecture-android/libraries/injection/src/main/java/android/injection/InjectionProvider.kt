package android.injection

import android.injection.factory.DefinitionFactory
import android.injection.factory.InjectionFactory
import java.util.concurrent.ConcurrentHashMap
import kotlin.reflect.KClass
import kotlin.reflect.full.allSuperclasses

typealias Definition<T> = () -> T
typealias QualifierValue = String

// TODO: make private
object InjectionProvider {
    val definitionRegistry: MutableMap<String, InjectionFactory<Any>> = ConcurrentHashMap()
    val moduleRegistry: MutableMap<String, Module> = ConcurrentHashMap()

    inline fun module(moduleName: String, block: Module.() -> Unit) {
        provider.moduleRegistry[moduleName]?.let {
            error("module $moduleName already exists")
        }
        val module = Module(moduleName).apply(block)
        provider.moduleRegistry[moduleName] = module
    }

    @Suppress("UNCHECKED_CAST")
    fun <T : Any> getDefinition(
        clazz: KClass<T>,
        qualifier: QualifierValue? = null,
    ): T {
        val declaration = definitionRegistry[key(clazz, qualifier)]
        val instance = declaration?.get()
        instance ?: run {
            var keys = "["
            for (entry in definitionRegistry.keys.sorted()) {
                keys += "\n   $entry"
            }
            keys += "\n]"
            val error = IllegalStateException(
                "Unable to find declaration of type ${clazz.qualifiedName} ${qualifier?.let { "with qualifier: \"$qualifier\"" } ?: ""}" +
                        "\n   Please declare:\n" +
                        "        provides {\n" +
                        "            declare<${clazz.simpleName}>${qualifier?.let { "(qualifier = \"$qualifier\")" } ?: ""} { TheImplementationOf${clazz.simpleName}() }\n" +
                        "        }" +
                        "\n\n" +
                        "Definitions: $keys"
            )
            throw error
        }
        return instance as T
    }

    inline fun <reified T : Any> declare(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        definitionRegistry[key(T::class, qualifier)] = DefinitionFactory(definition)
    }

    inline fun <reified T : Any> declareWithSuperClasses(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        definitionRegistry[key(T::class, qualifier)] = DefinitionFactory(definition)
        for (superClass: KClass<*> in T::class.allSuperclasses) {
            if (!superClass.simpleName.equals("Any")) {
                definitionRegistry[key(superClass, qualifier)] = DefinitionFactory(definition)
            }
        }
    }

    fun <T : Any> key(kClass: KClass<T>, qualifier: QualifierValue?): String {
        return """(${kClass.qualifiedName}${qualifier?.let { " - $qualifier" } ?: ""})"""
    }

}
