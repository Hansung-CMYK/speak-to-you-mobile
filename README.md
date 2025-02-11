# ego

2025 한성대학교 캡스톤디자인

## Documents

- [코드 컨벤션](https://6-keem-dev.vercel.app/blog/%EC%BA%A1%EC%8A%A4%ED%86%A4%EB%94%94%EC%9E%90%EC%9D%B8/2025-02-05)
- [아키텍쳐 구조](https://6-keem-dev.vercel.app/blog/%EC%BA%A1%EC%8A%A4%ED%86%A4%EB%94%94%EC%9E%90%EC%9D%B8/2025-02-12)


```bash
lib/
├── models/                # 데이터 모델
│   └── user_model.dart    # 예제: 사용자 데이터 모델
├── providers/             # 상태 관리
│   ├── user_provider.dart # 예제: 사용자 정보 Provider
│   ├── auth_provider.dart # 예제: 인증 상태 관리 Provider
│   └── theme_provider.dart # 예제: 다크모드 등의 UI 상태 관리 Provider
├── screens/               # 화면 구성
│   ├── home_screen.dart   # 홈 화면
│   ├── login_screen.dart  # 로그인 화면
│   ├── profile_screen.dart # 프로필 화면
│   └── settings_screen.dart # 설정 화면
├── services/              # API 통신 및 데이터 관리
│   ├── api_service.dart   # 예제: API 요청 처리
│   └── auth_service.dart  # 예제: 로그인 관련 로직
├── utils/                 # 유틸리티 및 헬퍼 함수
│   ├── constants.dart     # 상수값 관리
│   └── theme.dart         # 테마 관련 설정
├── widgets/               # 재사용 가능한 위젯
│   ├── custom_button.dart # 예제: 공통 버튼 위젯
│   ├── custom_textfield.dart # 예제: 공통 입력 필드
│   └── loading_spinner.dart # 예제: 로딩 인디케이터
└── main.dart              # 앱의 진입점
```