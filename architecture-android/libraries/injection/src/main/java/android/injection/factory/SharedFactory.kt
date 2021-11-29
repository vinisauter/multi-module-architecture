package android.injection.factory

class SharedFactory<T> (
    private val definition: Definition<T>
     ) : InjectionFactory<T> {
     private val instance: T by lazy { definition.invoke() }

     override fun get() = instance
 }