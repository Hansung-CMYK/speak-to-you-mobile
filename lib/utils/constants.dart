const String SERVICE_NAME = "SPEAK TO YOU";

/// 사용자의 대화에서 분류될 수 있는 감정들의 종류이다.
/// [anger] 분노
/// [disappointment] 실망
/// [embarrassment] 황당
/// [happiness] 행복
/// [sadness] 슬픔
enum Emotion {
  anger, disappointment, embarrassment, happiness, sadness
}

// local device base url
const String baseUrl = 'http://10.0.2.2:8080/api/v1';
const String webSocketUrl = 'ws://localhost:12345/ws'; // TODO 안드로이드에 맞는 Port로 변경 필요