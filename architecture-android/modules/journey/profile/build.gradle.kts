import libary.Project.APP

plugins {
    id(GradlePluginId.DYNAMIC_FEATURE)
    id(GradlePluginId.KOTLIN_ANDROID)
    id(GradlePluginId.KOTLIN_KAPT)
    id(GradlePluginId.KOTLIN_PARCELIZE)
    id(GradlePluginId.DEV_TOOLS)
    id(GradlePluginId.SAFE_ARGS)
}
android {
    compileSdk = (31)

    defaultConfig {
        minSdk = AndroidConfig.MIN_SDK
        testInstrumentationRunner = AndroidConfig.TEST_INSTRUMENTATION_RUNNER
    }
    buildFeatures {
        viewBinding = AndroidConfig.BuildFeatures.VIEW_BINDING
        dataBinding = AndroidConfig.BuildFeatures.DATA_BINDING
    }

    buildTypes {
        getByName(AndroidConfig.BuildType.RELEASE) {
            isMinifyEnabled = AndroidConfig.BuildTypeRelease.isMinifyEnabled
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    sourceSets {
        named("main") {
            java.srcDir("build/generated/ksp/${this.name}/kotlin/")
            java.srcDirs("build/generated/ksp/${this.name}/resources/")
        }
    }
}

dependencies {
    implementation(project(path = "$APP"))
    ksp(project(path = ("${libary.Project.AUTO_SERVICE_PROCESSOR}")))

    testImplementation("${libary.LibrariesAndroid.JUNIT}${libary.Version.JUNIT}")
    androidTestImplementation("${libary.LibrariesAndroid.JUNIT_TEST}${libary.Version.JUNIT_TEST}")
    androidTestImplementation("${libary.LibrariesAndroid.EXPRESSO}${libary.Version.ESPRESSO}")
    androidTestImplementation("${libary.LibrariesAndroid.ANNOTATION}${libary.Version.ANNOTATION}")
}
