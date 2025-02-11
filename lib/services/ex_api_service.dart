import 'dart:convert';
import '../models/ex_user_model.dart';

class ApiService {
  static const String _baseUrl = 'https://api.example.com';

  // 사용자 데이터 가져오기
  Future<UserModel?> fetchUser(String userId) async {
    // final response = await http.get(Uri.parse('$_baseUrl/users/$userId'));
    //
    // if (response.statusCode == 200) {
    //   return UserModel.fromJson(jsonDecode(response.body));
    // } else {
    //   return null;
    // }
  }
}
