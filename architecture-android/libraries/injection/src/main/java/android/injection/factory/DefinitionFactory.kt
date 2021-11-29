package android.injection.factory

class DefinitionFactory<T>(
    private val definition: Definition<T>
) : InjectionFactory<T> {
    override fun get() = definition.invoke()
}