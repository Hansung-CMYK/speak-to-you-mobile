import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setUid(String uid) async {
    await _prefs.setString('uid', uid);
  }

  static String? getUid() => _prefs.getString('uid');

}