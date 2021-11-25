package android.injection

import android.injection.factory.InjectionProvider
import android.injection.factory.QualifierValue

val provider = InjectionProvider

inline fun provides(block: InjectionProvider.() -> Unit) = provider.apply(block)

fun loadModule(moduleName: String){
    provider.moduleRegistry[moduleName]?.run{
        definitions.forEach{
            instances[it.key] = it.value.invoke()
        }
    }
}

fun unloadModule(moduleName: String) {
    provider.moduleRegistry[moduleName]?.instances?.clear()
}

inline fun <reified T : Any> get(
    qualifier: QualifierValue? = null,
): T {
    return provider.getDefinition(T::class, qualifier)
}

inline fun <reified T : Any> inject(
    qualifier: QualifierValue? = null,
    mode: LazyThreadSafetyMode = LazyThreadSafetyMode.SYNCHRONIZED,
) = lazy(mode) { get<T>(qualifier) }

