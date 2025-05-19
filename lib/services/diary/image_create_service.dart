import 'package:http/http.dart' as http;

import 'package:ego/utils/constants.dart';

class ImageCreateService {
  // 일기 이미지 생성 요청
  static Future<String> sendGenImageRequest({required String prompt}) async {
    final query = Uri.encodeComponent(prompt);

    final response = await http.post(
      Uri.parse('${genImageUrl}?prompt_ko=${query}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return response.body.trim().replaceAll('"', '');
    } else {
      throw Exception('일기 이미지 생성 실패: ${response.body}');
    }
  }
}
