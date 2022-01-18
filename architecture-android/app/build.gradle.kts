import libary.Version
import modules.Dependencies
import modules.addAll

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("kotlin-kapt")
    id("kotlin-parcelize")
    id("com.google.devtools.ksp")
    id("androidx.navigation.safeargs.kotlin")
}

android {
    compileSdk = (31)

    defaultConfig {
        applicationId = ("com.example.app")
        minSdk = (21)
        targetSdk = (31)
        versionCode = (1)
        versionName = ("1.0")

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
    buildFeatures {
        viewBinding = true
        dataBinding = true
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
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
        Dependencies.LOGIN,
        Dependencies.PROFILE,
        Dependencies.NETWORKING,
        Dependencies.NETWORKING_SECURE,
        Dependencies.NETWORKING_SECUREV2,
        Dependencies.STORAGE,
        Dependencies.TAGGING,
        Dependencies.SECURITY
    )
}

dependencies {

    api(project(path = (":libraries:auto-service:annotations")))
    ksp(project(path = (":libraries:auto-service:processor")))
    api(project(path = (":libraries:bug-finder")))
    api(project(path = (":libraries:injection")))

    api(project(path = (":engineering:interfaces:networking-interface")))
    api(project(path = (":engineering:interfaces:storage-interface")))
    api(project(path = (":engineering:interfaces:tagging-interface")))
    api(project(path = (":engineering:interfaces:security-interface")))

    api("androidx.core:core-ktx:${Version.CORE}")
    api("androidx.activity:activity-ktx:${Version.ACTIVITIY}")
    api("androidx.fragment:fragment-ktx:${Version.FRAGMENT}")

    api("androidx.appcompat:appcompat:${Version.APPCOMPAT}")
    api("androidx.constraintlayout:constraintlayout:${Version.CONSTRAINTLAYOUT}")
    api("com.google.android.material:material:${Version.MATERIAL}")
    api("com.google.android.play:core-ktx:${Version.PLAYCORE}")

    api("androidx.navigation:navigation-fragment-ktx:${Version.NAVIGATON}")
    api("androidx.navigation:navigation-ui-ktx:${Version.NAVIGATON}")
    api("androidx.navigation:navigation-dynamic-features-fragment:${Version.NAVIGATON}")

    testImplementation("junit:junit:${Version.JUNIT}")
    androidTestImplementation("androidx.test.ext:junit:${Version.JUNIT_TEST}")
    androidTestImplementation("androidx.test.espresso:espresso-core:${Version.ESPRESSO}")
}