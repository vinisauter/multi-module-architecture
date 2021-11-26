package android.injection

import android.injection.factory.InjectionProvider
import android.injection.factory.QualifierValue
import kotlinx.coroutines.internal.synchronized

val provider = InjectionProvider

inline fun provides(block: InjectionProvider.() -> Unit) = provider.apply(block)

@Synchronized
fun module(moduleName: String, block: Module.() -> Unit) = provider.module(moduleName,block)


inline fun <reified T : Any> get(
    qualifier: QualifierValue? = null,
): T {
    return provider.getDefinition(T::class, qualifier)
}

inline fun <reified T : Any> inject(
    qualifier: QualifierValue? = null,
    mode: LazyThreadSafetyMode = LazyThreadSafetyMode.SYNCHRONIZED,
) = lazy(mode) { get<T>(qualifier) }