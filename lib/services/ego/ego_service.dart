import 'dart:convert';
import 'package:ego/models/ego_model.dart';
import 'package:ego/utils/constants.dart';
import 'package:http/http.dart' as http;

class EgoService {
  static Future<List<EgoModel>> fetchAllEgoList() async {
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

  static Future<EgoModel> fetchEgoById(int egoId) async {
    final response = await http.get(Uri.parse('$baseUrl/ego/$egoId'));

    if (response.statusCode == 200) {
      // response.body 대신 bodyBytes 사용하여 UTF-8로 디코딩
      final json = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> decodedJson = jsonDecode(json);

      final egoData = decodedJson['data'];

      // 데이터를 EgoModel로 변환하여 반환
      return EgoModel.fromJson(egoData);
    } else {
      throw Exception('Ego 정보 불러오기 실패: ${response.statusCode}');
    }
  }
}
