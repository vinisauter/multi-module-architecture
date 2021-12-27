package android.injection.factory

class SharedFactory<T>(private val instance: T) : InjectionFactory<T> {
    override fun get() = instance
}