import 'dart:convert';
import 'package:ego/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../models/chat/chat_room_model.dart';

class ChatRoomService {
  static Future<List<ChatRoomModel>> fetchChatRoomList({
    required String uid,
    required int pageNum,
    required int pageSize
  }) async {
    final uri = Uri.parse('$baseUrl/chat-room/list?pageNum=$pageNum&pageSize=$pageSize');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'uid': uid});

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      final json = utf8.decode(response.bodyBytes); // 한글 깨짐 방지
      final Map<String, dynamic> decodedJson = jsonDecode(json);
      final List<dynamic> dataList = decodedJson['data'];

      return dataList.map((e) => ChatRoomModel.fromJson(e)).toList();
    } else {
      throw Exception('채팅방 목록 불러오기 실패: ${response.statusCode}');
    }
  }
}
