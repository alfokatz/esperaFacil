
val prodVersionCode = project.property("prodVersionCode").toString().toInt()
val prodVersionName = project.property("prodVersionName").toString()

val stgVersionCode = project.property("stgVersionCode").toString().toInt()
val stgVersionName = project.property("stgVersionName").toString()

val devVersionCode = project.property("devVersionCode").toString().toInt()
val devVersionName = project.property("devVersionName").toString()

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.template"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.thinkup.template"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        ndkVersion = "27.0.12077973"
    }

    buildTypes {
        debug {
            isMinifyEnabled = false
        }
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    flavorDimensions += "default"

    productFlavors {
        create("production") {
            dimension = "default"
            versionCode = prodVersionCode
            versionName = prodVersionName
            resValue(
                type = "string",
                name = "app_name",
                value = "Prod template"
            )
            applicationId = "com.thinkup.template"
        }
        create("staging") {
            dimension = "default"
            versionCode = stgVersionCode
            versionName = stgVersionName
            resValue(
                type = "string",
                name = "app_name",
                value = "Stg template"
            )
            applicationId = "com.thinkup.template.stg"
            versionNameSuffix = "-staging"
        }
        create("development") {
            dimension = "default"
            versionCode = devVersionCode
            versionName = devVersionName
            resValue(
                type = "string",
                name = "app_name",
                value = "Dev template"
            )
            applicationId = "com.thinkup.template.dev"
            versionNameSuffix = "-development"
        }
    }
}

flutter {
    source = "../.."
}
