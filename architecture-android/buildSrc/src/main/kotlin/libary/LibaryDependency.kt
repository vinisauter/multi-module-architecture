package libary

object Version {
    const val NAVIGATON = "2.4.0-beta02"
    const val CONSTRAINTLAYOUT = "2.1.1"
    const val APPCOMPAT = "1.3.1"
    const val MATERIAL = "1.4.0"
    const val PLAY_CORE = "1.8.1"
    const val FRAGMENT = "1.4.0"
    const val ACTIVITY = "1.4.0"
    const val ANNOTATION = "1.3.0"
    const val CORE = "1.7.0"
    const val JUNIT = "4.13.2"
    const val JUNIT_TEST = "1.1.3"
    const val ESPRESSO = "3.4.0"
}

object LibrariesAndroid {
    const val CORE = "androidx.core:core-ktx:"
    const val ACTIVITY = "androidx.activity:activity-ktx:"
    const val FRAGMENT = "androidx.fragment:fragment-ktx:"

    const val APPCOMPAT = "androidx.appcompat:appcompat:"
    const val CONSTRAINTLAYOUT = "androidx.constraintlayout:constraintlayout:"
    const val MATERIAL = "com.google.android.material:material:"
    const val PLAY_CORE = "com.google.android.play:core-ktx:"
    const val ANNOTATION = "androidx.annotation:annotation:"


    /* lib navigation*/
    const val NAVIGATON = "androidx.navigation:navigation-fragment-ktx:"
    const val NAVIGATON_UI = "androidx.navigation:navigation-ui-ktx:"
    const val NAVIGATON_DYNAMIC_FEATURES =
        "androidx.navigation:navigation-dynamic-features-fragment:"

    /* lib test*/
    const val JUNIT = "junit:junit:"
    const val JUNIT_TEST = "androidx.test.ext:junit:"
    const val EXPRESSO = "androidx.test.espresso:espresso-core:"
}

object Project {
    const val APP = ":app"
    const val AUTO_SERVICE_ANNOTATION = ":libraries:auto-service:annotations"
    const val AUTO_SERVICE_PROCESSOR = ":libraries:auto-service:processor"
    const val BUG_FINDER = ":libraries:bug-finder"
    const val INJECTION = ":libraries:injection"

    const val INTERFACE_NETWORK = ":engineering:interfaces:networking-interface"
    const val INTERFACE_STORAGE = ":engineering:interfaces:storage-interface"
    const val INTERFACE_TAGGING = ":engineering:interfaces:tagging-interface"
    const val INTERFACE_SECURUTY = ":engineering:interfaces:security-interface"

}