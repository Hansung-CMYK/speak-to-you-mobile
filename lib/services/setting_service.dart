import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();

  factory SettingsService() => _instance;

  SettingsService._internal();

  static const _hostUrl = 'host';
  static const _dbPortKey = 'db_port';
  static const _wsTextPortKey = 'ws_port';
  static const _diaryPortKey = 'diary_port';
  static const _imagePortKey = 'image_port';

  late SharedPreferences _prefs;


  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // --- Setters ---
  Future<void> setHost(String host) async {
    await _prefs.setString(_hostUrl, host);
  }

  Future<void> setApiPort(String port) async {
    await _prefs.setString(_dbPortKey, port);
  }

  Future<void> setWsPort(String port) async {
    await _prefs.setString(_wsTextPortKey, port);
  }

  Future<void> setDiaryPort(String port) async {
    await _prefs.setString(_diaryPortKey, port);
  }

  Future<void> setImagePort(String port) async {
    await _prefs.setString(_imagePortKey, port);
  }


  // --- Getters ---
  String get host => _prefs.getString(_hostUrl) ?? '10.0.2.2'; // build 할때는 localhost로 수정

  String get dbPort => _prefs.getString(_dbPortKey) ?? '11111'; // DB에 저장 - 30080
  String get wsTextPort => _prefs.getString(_wsTextPortKey) ?? '22222'; // text ws 통신 - 8000
  String get diaryCreatePort => _prefs.getString(_diaryPortKey) ?? '33333'; // 일기 생성 - 8003
  String get imageGenPort => _prefs.getString(_imagePortKey) ?? '44444'; // 이미지 생성 - 8003

  // --- URLs ---
  String get dbUrl => 'http://$host:$dbPort/api/v1';
  String get webSocketUrl => 'ws://$host:$wsTextPort/ws';
  String get diaryCreateUrl => 'http://$host:$diaryCreatePort/api/diary';
  String get genImageUrl => 'http://$host:$imageGenPort/api/image';
  String get webVoiceUrl => 'ws://$host:$diaryCreatePort/api/ws';
}