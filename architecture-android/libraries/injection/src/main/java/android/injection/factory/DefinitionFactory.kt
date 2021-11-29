package android.injection.factory

import android.injection.Definition

class DefinitionFactory<T>(
    private val definition: Definition<T>
) : InjectionFactory<T> {
    override fun get() = definition.invoke()
}