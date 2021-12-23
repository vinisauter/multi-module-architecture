package android.injection

import android.app.Activity
import android.util.Log
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver

val provider = InjectionProvider

inline fun provides(block: InjectionProvider.() -> Unit) = provider.apply(block)
inline fun Any.module(
    moduleName: String = this::class.java.simpleName,
    lifecycle: Lifecycle,
    activity: Activity,
    block: Module.() -> Unit
): Module {
    val existingModule = provider.moduleRegistry[moduleName]
    if (existingModule != null) {
        Log.w("injection", "module $moduleName ignored already exists")
        return existingModule
    }
    val module = Module(moduleName).apply(block)
    provider.moduleRegistry[moduleName] = module

    lifecycle.addObserver(LifecycleEventObserver { _, event ->
        if (event == Lifecycle.Event.ON_DESTROY) {
            val shouldClear = !activity.isChangingConfigurations
            if (shouldClear) {
                module.clear()
            }
        }
    })
    return module
}

@Synchronized
fun moduleRemove(moduleName: String) {
    provider.moduleRegistry[moduleName]?.clear()
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