object AndroidConfig {
    const val APPLICATION_ID = "com.example.app"
    const val MIN_SDK = 21
    const val TARGET_SDK = 31
    const val VERSION_CODE = 1
    const val VERSION_NAME = "1.0"
    const val TEST_INSTRUMENTATION_RUNNER = "androidx.test.runner.AndroidJUnitRunner"

    object BuildFeatures {
        const val VIEW_BINDING = true
        const val DATA_BINDING = true
    }

    interface BuildType {

        companion object {
            const val RELEASE = "release"
        }

        val isMinifyEnabled: Boolean
    }

    object BuildTypeRelease : BuildType {
        override val isMinifyEnabled = false
    }
}