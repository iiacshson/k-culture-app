import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle Plugin은 Android, Kotlin 플러그인 뒤에 와야 함
    id("dev.flutter.flutter-gradle-plugin")
}

// key.properties 파일 로드
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    // 패키지 이름 (원하면 나중에 바꿀 수 있음)
    namespace = "com.seokh.kcultureapp"

    // flutter 객체에서 값 가져오는 문법 (Kotlin DSL 형식)
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    // 서명 설정
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    defaultConfig {
        // 실제 앱 패키지 ID (나중에 Play 콘솔 올릴 때 사용)
        applicationId = "com.seokh.kcultureapp"

        // 최소/타겟 SDK도 flutter 쪽 값 사용
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        // 버전 정보 – Flutter가 local.properties에 써준 값 사용
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // 릴리즈 서명 사용
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

// Flutter가 이 Android 모듈을 어디서 가져오냐 설정
flutter {
    source = "../.."
}
