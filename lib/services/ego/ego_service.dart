import 'dart:convert';
import 'package:ego/models/chat/chat_room_model.dart';
import 'package:ego/models/ego_model.dart';
import 'package:ego/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../providers/ego_provider.dart';

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

  static Future<List<EgoModel>> fetchEgoModelsForChatRooms(List<ChatRoomModel> chatRoomList, WidgetRef ref) async {
    // 각 chatRoom에 대한 egoId를 기반으로 egoModel Future 리스트 생성
    final futures = chatRoomList.map(
          (chatRoom) => ref.watch(egoByIdProvider(chatRoom.egoId).future), // egoId로 EgoModel 가져오기
    ).toList();

    // 여러 개의 future를 기다리기 위해 Future.wait 사용
    return await Future.wait(futures);
  }
}
