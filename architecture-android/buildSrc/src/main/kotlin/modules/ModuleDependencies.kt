package modules

object ModuleDependencies {

    object Negotial {
        const val LOGIN = ":modules:journey:login"
        const val PROFILE = ":modules:journey:profile"
        const val HOME = ":modules:journey:home"
    }

    object Structural {
        const val NETWORKING = ":modules:structural:networking"
        const val NETWORKING_SECURE = ":modules:structural:networkingsecure"
        const val NETWORKING_SECUREV2 = ":modules:structural:networkingsecurev2"
        const val STORAGE = ":modules:structural:storage"
        const val TAGGING = ":modules:structural:tagging"
        const val SECURITY = ":modules:structural:security"
    }

}
