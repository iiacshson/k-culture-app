# K Culture App

외국인을 위한 한국 문화 소개 Flutter 앱

## 프로젝트 개요

- **앱 이름**: Korea Quiz & Guide
- **패키지명**: `com.seokh.kcultureapp`
- **Flutter SDK**: ^3.10.0
- **버전**: 1.0.0+1
- **GitHub**: https://github.com/iiacshson/k-culture-app

## 주요 기능

### 1. Quiz (퀴즈)
한국 문화에 대한 다양한 퀴즈 제공

**카테고리**:
- **K-Food**: 김치, 삼겹살, 떡볶이 등 한국 음식
- **Etiquette**: 한국 예절 (두 손 사용, 어른 공경 등)
- **K-POP & Drama**: BTS, 한국 드라마 관련
- **Daily Life**: 편의점, T-Money, 일상생활
- **Tradition**: 한복, 한옥, 추석 등 전통문화

**구현 화면**:
- `QuizHomeScreen`: 퀴즈 홈 (카테고리 선택)
- `QuizPlayScreen`: 퀴즈 진행 화면
- `QuizResultScreen`: 결과 화면

### 2. Discover (여행지 발견)
한국 주요 관광지 및 핫플레이스 정보 제공

**수록 장소**:
- 서울: 홍대, 성수동, 경복궁, 광장시장, 북촌한옥마을, 남산타워, 한강공원
- 부산: 해운대, 감천문화마을
- 제주: 성산일출봉

**구현 화면**:
- `DiscoverScreen`: 장소 목록
- `PlaceDetailScreen`: 장소 상세 (설명 + 팁)

### 3. Games (한국 술게임)
외국인에게 한국 술게임 규칙 설명

**수록 게임**:
- 삼육구 게임 (3-6-9)
- 바스킨라빈스 31
- 눈치 게임
- 왕게임
- Truth or Drink
- 손가락 게임 (Never Have I Ever)
- 조용한 007빵
- 초성 게임
- 폰 룰렛

**구현 화면**:
- `DrinkingGameScreen`: 게임 목록
- `DrinkingGameDetailScreen`: 게임 규칙 및 팁

## 프로젝트 구조

```
k_culture_app/
├── lib/
│   └── main.dart              # 전체 앱 코드 (단일 파일)
├── android/
│   ├── app/
│   │   ├── build.gradle.kts   # 앱 빌드 설정 (서명 포함)
│   │   ├── keystore/          # 앱 서명 키 (Git 제외)
│   │   └── src/main/
│   │       └── AndroidManifest.xml
│   └── key.properties         # 서명 비밀번호 (Git 제외)
├── docs/
│   └── privacy-policy.html    # 개인정보처리방침
├── ios/                       # iOS 네이티브 설정
├── web/                       # 웹 설정
├── windows/                   # Windows 데스크톱 설정
├── macos/                     # macOS 데스크톱 설정
├── linux/                     # Linux 데스크톱 설정
└── pubspec.yaml               # 의존성 및 앱 설정
```

## 의존성

```yaml
dependencies:
  flutter: sdk
  cupertino_icons: ^1.0.8
  google_mobile_ads: ^5.2.0    # Google 모바일 광고

dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^6.0.0
```

## 광고 설정 (AdMob)

✅ **실제 광고 ID 적용 완료**

| 항목 | 값 |
|------|-----|
| **AdMob App ID** | `ca-app-pub-0035864962085153~2789594686` |
| **배너 광고 단위 ID** | `ca-app-pub-0035864962085153/7522104669` |
| **광고 위치** | 각 화면 하단 `AdBanner` 위젯 |

**설정 파일**:
- `android/app/src/main/AndroidManifest.xml` - AdMob App ID
- `lib/main.dart:2326` - 배너 광고 단위 ID

## 앱 서명 설정

✅ **릴리즈 서명 설정 완료**

| 항목 | 값 |
|------|-----|
| **Keystore 위치** | `android/app/keystore/upload-keystore.jks` |
| **Key Alias** | `upload` |
| **비밀번호** | `kculture2024!` |
| **유효기간** | 10,000일 |

⚠️ **중요**: keystore 파일과 비밀번호는 반드시 백업! 분실 시 앱 업데이트 불가

**관련 파일** (Git 제외됨):
- `android/key.properties` - 서명 비밀번호
- `android/app/keystore/upload-keystore.jks` - 서명 키

## 개인정보처리방침

✅ **생성 완료**

- **파일**: `docs/privacy-policy.html`
- **GitHub Pages URL**: https://iiacshson.github.io/k-culture-app/privacy-policy.html

## 테마 및 디자인

- **Material 3** 사용
- **Seed Color**: `#E63946` (레드톤)
- **배경색**: `#FDF7F7` (연한 핑크)
- 각 섹션별 그라디언트 헤더:
  - Quiz: 핑크/살몬 그라디언트
  - Discover: 민트/스카이블루 그라디언트
  - Games: 오렌지/골드 그라디언트

## 네비게이션

`NavigationBar`를 사용한 3탭 구조:
1. Quiz (퀴즈 아이콘)
2. Discover (지도 아이콘)
3. Games (바 아이콘)

## 데이터 구조

### Question (퀴즈 문제)
```dart
class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final QuizCategory category;
  final String? explanation;
}
```

### Place (장소 정보)
```dart
class Place {
  final String name;
  final String area;
  final String category;
  final String shortDesc;
  final String detail;
  final List<String> tips;
  final List<String> tags;
}
```

### DrinkingGame (술게임)
```dart
class DrinkingGame {
  final String name;
  final String koreanName;
  final String shortDesc;
  final String rules;
  final String players;
  final String difficulty;
  final List<String> tips;
  final List<String> tags;
}
```

## 빌드 및 실행

```bash
# 의존성 설치
flutter pub get

# 개발 실행 (Android/iOS)
flutter run

# 릴리즈 빌드 (Android AAB - Play Store용)
flutter build appbundle

# 릴리즈 빌드 (Android APK)
flutter build apk --release

# 릴리즈 빌드 (iOS)
flutter build ios
```

**빌드 결과물 위치**:
- AAB: `build/app/outputs/bundle/release/app-release.aab`
- APK: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📋 To-Do List

### ✅ 완료된 작업

- [x] 앱 기본 기능 구현 (Quiz, Discover, Games)
- [x] AdMob 실제 광고 ID 적용
- [x] 패키지명 변경 (`com.example` → `com.seokh.kcultureapp`)
- [x] 앱 서명 키 생성 (keystore)
- [x] 릴리즈 빌드 설정
- [x] 개인정보처리방침 페이지 생성
- [x] GitHub Repository 생성 및 코드 Push
- [x] AAB 빌드 완료

### 🔲 진행 필요 작업

- [ ] **GitHub Pages 활성화**
  - https://github.com/iiacshson/k-culture-app/settings/pages
  - Branch: `main` / Folder: `/docs` 선택

- [ ] **Play Console 앱 등록**
  - https://play.google.com/console 접속
  - 앱 만들기 → 정보 입력

- [ ] **스토어 등록 정보 준비**
  - 앱 스크린샷 (최소 2장)
  - 앱 아이콘 512x512 PNG
  - 앱 설명 (영문)
  - 개인정보처리방침 URL 등록

- [ ] **앱 심사 제출**
  - AAB 파일 업로드
  - 콘텐츠 등급 설정
  - 타겟 연령 설정

### 🔮 향후 개선 사항

1. **코드 분리**: main.dart를 여러 파일로 분리 (models/, screens/, widgets/)
2. **상태 관리**: Provider/Riverpod 등 상태 관리 도입
3. **다국어 지원**: 영어 외 다른 언어 추가
4. **이미지 추가**: 장소/음식 이미지 포함
5. **로컬 저장소**: 퀴즈 점수 기록 저장
6. **iOS 배포**: App Store 등록

---

## 참고사항

- 모든 텍스트는 **영어**로 작성 (외국인 대상)
- 술게임 섹션에 **책임감 있는 음주 안내** 포함
- 한국어 원어 함께 표기 (예: "Hanbok (한복)")

## 최종 업데이트

- **날짜**: 2024-11-29
- **작업 내용**: 광고 설정, 앱 서명, 개인정보처리방침, GitHub 연동 완료
