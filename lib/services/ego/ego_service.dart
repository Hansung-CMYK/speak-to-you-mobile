import 'dart:convert';
import 'package:ego/models/chat/chat_room_model.dart';
import 'package:ego/models/ego_model_v1.dart';
import 'package:ego/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:ego/providers/ego_provider.dart';

class EgoService {
  /**
   * 서비스에 존재하는 전체 EGO List를 요청합니다.
   * */
  static Future<List<EgoModelV1>> fetchAllEgoList() async {
    final response = await http.get(Uri.parse('$baseUrl/ego'));

    if (response.statusCode == 200) {
      // response.body 대신 bodyBytes 사용하여 UTF-8로 디코딩
      final json = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> decodedJson = jsonDecode(json);

      final List<dynamic> dataList = decodedJson['data'];

      return dataList.map((e) => EgoModelV1.fromJson(e)).toList();
    } else {
      throw Exception('Ego 목록 불러오기 실패: ${response.statusCode}');
    }
  }

  /**
   * 특정 EGOID를 가지는 EGO를 요청합니다.
   * */
  static Future<EgoModelV1> fetchEgoById(int egoId) async {
    final response = await http.get(Uri.parse('$baseUrl/ego/$egoId'));

    if (response.statusCode == 200) {
      // response.body 대신 bodyBytes 사용하여 UTF-8로 디코딩
      final json = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> decodedJson = jsonDecode(json);

      final egoData = decodedJson['data'];

      // 데이터를 EgoModel로 변환하여 반환
      return EgoModelV1.fromJson(egoData);
    } else {
      throw Exception('Ego 정보 불러오기 실패: ${response.statusCode}');
    }
  }

  /**
   * 전달된 ChatRoomModel들을 바탕으로 EGO정보를 조회합니다.
   * */
  static Future<List<EgoModelV1>> fetchEgoModelsForChatRooms(List<ChatRoomModel> chatRoomList, WidgetRef  ref) async {
    // 각 chatRoom에 대한 egoId를 기반으로 egoModel Future 리스트 생성
    final futures = chatRoomList.map(
          (chatRoom) => ref.watch(egoByIdProvider(chatRoom.egoId).future), // egoId로 EgoModel 가져오기
    ).toList();

    // 여러 개의 future를 기다리기 위해 Future.wait 사용
    return await Future.wait(futures);
  }
}
