
import libary.LibrariesAndroid.ACTIVITY
import libary.Project.AUTO_SERVICE_ANNOTATION
import libary.Project.AUTO_SERVICE_PROCESSOR
import libary.Project.BUG_FINDER
import libary.Project.INJECTION
import libary.Project.INTERFACE_NETWORK
import libary.Project.INTERFACE_SECURUTY
import libary.Project.INTERFACE_STORAGE
import libary.Project.INTERFACE_TAGGING
import libary.Version
import libary.Version.CORE
import modules.ModuleDependencies
import modules.addAll

plugins {
    id(GradlePluginId.ANDROID_APPLICATION)
    id(GradlePluginId.KOTLIN_ANDROID)
    id(GradlePluginId.KOTLIN_KAPT)
    id(GradlePluginId.KOTLIN_PARCELIZE)
    id(GradlePluginId.DEV_TOOLS)
    id(GradlePluginId.SAFE_ARGS)
}

android {
    compileSdk = (31)

    defaultConfig {
        applicationId = (AndroidConfig.APPLICATION_ID)
        minSdk = (AndroidConfig.MIN_SDK)
        targetSdk = (AndroidConfig.TARGET_SDK)
        versionCode = (AndroidConfig.VERSION_CODE)
        versionName = (AndroidConfig.VERSION_NAME)

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
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    sourceSets {
        named("main") {
            java.srcDir("build/generated/ksp/${this.name}/kotlin/")
            java.srcDirs("build/generated/ksp/${this.name}/resources/")
        }
    }

    dynamicFeatures.addAll(
        ModuleDependencies.Negotial.LOGIN,
        ModuleDependencies.Negotial.PROFILE,
        ModuleDependencies.Negotial.HOME,
        ModuleDependencies.Structural.NETWORKING,
        ModuleDependencies.Structural.NETWORKING_SECURE,
        ModuleDependencies.Structural.NETWORKING_SECUREV2,
        ModuleDependencies.Structural.STORAGE,
        ModuleDependencies.Structural.TAGGING,
        ModuleDependencies.Structural.SECURITY
    )
}

dependencies {

    api(project(path = ("${AUTO_SERVICE_ANNOTATION}")))
    ksp(project(path = ("$AUTO_SERVICE_PROCESSOR")))
    api(project(path = ("$BUG_FINDER")))
    api(project(path = ("$INJECTION")))

    api(project(path = ("$INTERFACE_NETWORK")))
    api(project(path = ("$INTERFACE_SECURUTY")))
    api(project(path = (INTERFACE_STORAGE)))
    api(project(path = ("$INTERFACE_TAGGING")))


    api("${libary.LibrariesAndroid.CORE}${Version.CORE}")
    api("${libary.LibrariesAndroid.ACTIVITY}${Version.ACTIVITY}")
    api("${libary.LibrariesAndroid.FRAGMENT}${Version.FRAGMENT}")

    api("${libary.LibrariesAndroid.APPCOMPAT}${Version.APPCOMPAT}")
    api("${libary.LibrariesAndroid.CONSTRAINTLAYOUT}${Version.CONSTRAINTLAYOUT}")
    api("${libary.LibrariesAndroid.MATERIAL}${Version.MATERIAL}")
    api("${libary.LibrariesAndroid.PLAY_CORE}${Version.PLAY_CORE}")

    api("${libary.LibrariesAndroid.NAVIGATON}${Version.NAVIGATON}")
    api("${libary.LibrariesAndroid.NAVIGATON_UI}${Version.NAVIGATON}")
    api("${libary.LibrariesAndroid.NAVIGATON_DYNAMIC_FEATURES}${Version.NAVIGATON}")

    testImplementation("${libary.LibrariesAndroid.JUNIT}${Version.JUNIT}")
    androidTestImplementation("${libary.LibrariesAndroid.JUNIT_TEST}${Version.JUNIT_TEST}")
    androidTestImplementation("${libary.LibrariesAndroid.EXPRESSO}${Version.ESPRESSO}")
}