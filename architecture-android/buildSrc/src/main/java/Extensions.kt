fun <T> MutableSet<T>.addAll(vararg items: T) {
    items.forEach { this.add(it) }
}