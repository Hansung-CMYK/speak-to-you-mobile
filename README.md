# ego

2025 한성대학교 캡스톤디자인

## Documents

- [코드 컨벤션](https://6-keem-dev.vercel.app/blog/%EC%BA%A1%EC%8A%A4%ED%86%A4%EB%94%94%EC%9E%90%EC%9D%B8/2025-02-05)
- [아키텍쳐 구조](https://6-keem-dev.vercel.app/blog/%EC%BA%A1%EC%8A%A4%ED%86%A4%EB%94%94%EC%9E%90%EC%9D%B8/2025-02-12)


```bash
lib/
├── models/                # 데이터 모델: 사용자, 상품 등 데이터 모델 클래스 정의 (예: user_model.dart)
│   └── user_model.dart    # 예제: 사용자 데이터 모델
├── providers/             # 상태 관리 (Riverpod): Riverpod을 사용해 상태 관리를 구현합니다.
│   ├── user_provider.dart # 예제: 사용자 정보 Riverpod Provider (예: StateNotifierProvider)
│   ├── auth_provider.dart # 예제: 인증 상태 관리 Riverpod Provider
│   └── theme_provider.dart# 예제: 다크모드 등의 UI 상태 관리 Riverpod Provider
├── screens/               # 화면 구성: 앱의 UI 화면들을 포함합니다.
│   ├── home_screen.dart   # 홈 화면
│   ├── login_screen.dart  # 로그인 화면
│   ├── profile_screen.dart# 프로필 화면
│   └── settings_screen.dart# 설정 화면
├── services/              # API 통신 및 데이터 관리: API 요청, 인증 서비스 등 비즈니스 로직을 포함합니다.
│   ├── api_service.dart   # 예제: API 요청 처리
│   └── auth_service.dart  # 예제: 로그인 관련 로직
├── utils/                 # 유틸리티 및 헬퍼 함수: 상수, 테마, 헬퍼 함수 등을 포함합니다.
│   ├── constants.dart     # 상수값 관리
│   └── theme.dart         # 테마 관련 설정
├── widgets/               # 재사용 가능한 위젯: CustomButton, LoadingSpinner 등 공통 UI 컴포넌트들을 포함합니다.
│   ├── custom_button.dart # 예제: 공통 버튼 위젯
│   ├── custom_textfield.dart# 예제: 공통 입력 필드
│   └── loading_spinner.dart# 예제: 로딩 인디케이터
└── main.dart              # 앱의 진입점: ProviderScope로 Riverpod 상태를 감싸고 앱을 초기화합니다.
```
