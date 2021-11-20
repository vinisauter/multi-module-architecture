package com.core.analytics

interface Tagging {
    fun sendScreenName(screenName: ScreenName)
    fun sendEvent(event: Event)
    fun sendEvent(category: String, action: String, label: String) {
        sendEvent(Event(category, action, label))
    }
}