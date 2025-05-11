import 'dart:convert';
import 'package:ego/models/ego_model.dart';
import 'package:ego/utils/constants.dart';
import 'package:http/http.dart' as http;

class EgoService {
  static Future<List<EgoModel>> fetchEgoList() async {
    final response = await http.get(Uri.parse('$baseUrl/ego'));

    if (response.statusCode == 200) {
      // response.body 대신 bodyBytes 사용하여 UTF-8로 디코딩
      final json = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> decodedJson = jsonDecode(json);

      final List<dynamic> dataList = decodedJson['data'];

      return dataList.map((e) => EgoModel.fromJson(e)).toList();
    } else {
      throw Exception('Ego 목록 불러오기 실패: ${response.statusCode}');
    }
  }
}
