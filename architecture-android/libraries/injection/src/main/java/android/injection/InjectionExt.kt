package android.injection

val provider = InjectionProvider

inline fun provides(block: InjectionProvider.() -> Unit) = provider.apply(block)
inline fun module(moduleName: String, block: Module.() -> Unit): Module {
    provider.moduleRegistry[moduleName]?.let {
        error("module $moduleName already exists")
    }
    val module = Module(moduleName).apply(block)
    provider.moduleRegistry[moduleName] = module
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