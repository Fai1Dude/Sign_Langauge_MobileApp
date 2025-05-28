
    plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")   // ← must be last
}

android {
    android {
    namespace = "com.example.yourapp"

    compileSdk = 35          //  ← raise from 33 → 35
    defaultConfig {
        applicationId = "com.example.yourapp"
        minSdk = 21
        targetSdk = 35       //  ← raise too
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
}


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions { jvmTarget = "11" }

    buildTypes {
        getByName("release") {
            // debug keys for now so `flutter run --release` works
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {                 // keep this exactly as Flutter generated
    source = "../.."
}
