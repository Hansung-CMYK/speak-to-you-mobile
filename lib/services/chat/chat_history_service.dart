import 'dart:convert';
import 'package:ego/models/chat/chat_history_model.dart';
import 'package:ego/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'package:ego/models/chat/chat_room_model.dart';

class ChatHistoryService {
  // page 단위로 ChatHistory를 가져옵니다.
  static Future<List<ChatHistory>> fetchChatHistoryList({
    required String uid,
    required int chatRoomId,
    required int pageNum,
    required int pageSize,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/chat-history/list?pageNum=$pageNum&pageSize=$pageSize',
    );
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'uid': uid, 'chatRoomId': chatRoomId});

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      final json = utf8.decode(response.bodyBytes); // 한글 깨짐 방지
      final Map<String, dynamic> decodedJson = jsonDecode(json);
      final List<dynamic> dataList = decodedJson['data'];

      return dataList.map((e) => ChatHistory.fromJson(e)).toList();
    } else {
      throw Exception('채팅방 내역 불러오기 실패: ${response.statusCode}');
    }
  }

  static Future<void> deleteChatMessage({
    required String uid,
    required String messageHash,
  }) async {

    final uri = Uri.parse('$baseUrl/chat-history/$uid/$messageHash');

    final headers = {'Content-Type': 'application/json'};


    final response = await http.delete(uri, headers: headers);


    if (response.statusCode != 200) {
      throw Exception('채팅 메시지 삭제 실패: ${response.statusCode}');
    }
  }

}
