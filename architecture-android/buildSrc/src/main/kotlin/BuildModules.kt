object BuildModules {
    const val APP = ":app"

    object Modules {
        const val Modules = ":modules"
        const val MODULES_STRUCTURAL = ":modules:structural"
        const val MODULES_STRUCTURAL_NETWORKING = ":modules:structural:networking"
        const val MODULES_STRUCTURAL_NETWORKING_SECURE = ":modules:structural:networkingsecure"
        const val MODULES_STRUCTURAL_NETWORKING_SECUREV2 = ":modules:structural:networkingsecurev2"
        const val MODULES_STRUCTURAL_STORAGE = ":modules:structural:storage"
        const val MODULES_STRUCTURAL_TAGGING = ":modules:structural:tagging"
        const val MODULES_STRUCTURAL_SECURITY = ":modules:structural:security"

        const val MODULES_JORNEY = ":modules:journey"
        const val MODULES_JORNEY_LOGIN = ":modules:journey:login"
        const val MODULES_JORNEY_HOME = ":modules:journey:home"
        const val MODULES_JORNEY_PROFILE = ":modules:journey:profile"

    }

    object Engineering {
        const val ENGINEERING = ":engineering"
        const val ENGINEERING_INTERFACES = ":engineering:interfaces"
        const val ENGINEERING_INTERFACES_NETWORKING_INTERFACE =
            ":engineering:interfaces:networking-interface"
        const val ENGINEERING_INTERFACES_STORAGE_INTERFACE =
            ":engineering:interfaces:storage-interface"
        const val ENGINEERING_INTERFACES_TAGGING_INTERFACE =
            ":engineering:interfaces:tagging-interface"
        const val ENGINEERING_INTERFACES_SECURITY_INTERFACE =
            ":engineering:interfaces:security-interface"
        const val ENGINEERING_IMPLEMENTATIONS = ":engineering:implementations"
        const val ENGINEERING_IMPLEMENTATION_NETWORKING_SECUREV2 =
            ":engineering:implementations:networkingsecurev2"
    }

    object Libraries {
        const val LIBRARIES = ":libraries"
        const val LIBRARIES_BUGFINDER = ":libraries:bug-finder"
        const val LIBRARIES_INJECTION = ":libraries:injection"
        const val LIBRARIES_AUTO_SERVICE = ":libraries:auto-service"
        const val LIBRARIES_AUTO_SERVICE_ANDROID = ":libraries:auto-service:android"
        const val LIBRARIES_AUTO_SERVICE_ANNOTATIONS = ":libraries:auto-service:annotations"
        const val LIBRARIES_AUTO_SERVICE_PROCESSOR = ":libraries:auto-service:processor"
    }

}






