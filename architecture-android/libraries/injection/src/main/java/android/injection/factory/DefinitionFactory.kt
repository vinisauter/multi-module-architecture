package android.injection.factory

class DefinitionFactory<T>(
    private val definition: Definition<T>
) : Factory<T> {
    override fun get() = definition.invoke()
}