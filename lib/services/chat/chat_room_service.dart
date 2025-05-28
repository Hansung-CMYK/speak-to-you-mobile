import 'dart:convert';
import 'package:ego/services/setting_service.dart';
import 'package:ego/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'package:ego/models/chat/chat_room_model.dart';

class ChatRoomService {
  // page 단위로 ChatRoom을 가져옵니다.
  static Future<List<ChatRoomModel>> fetchChatRoomList({
    required String uid,
    required int pageNum,
    required int pageSize
  }) async {
    final uri = Uri.parse('${SettingsService().dbUrl}/chat-room/list?pageNum=$pageNum&pageSize=$pageSize');
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

  static Future<bool> deleteChatRoom({required String uid, required int egoId}) async {
    final url = Uri.parse('${SettingsService().dbUrl}/chat-room');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'uid': uid,
      'egoId': egoId,
    });

    final request = http.Request("DELETE", url)
      ..headers.addAll(headers)
      ..body = body;

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print('✅ 채팅방 삭제 성공');
      print('응답: $responseBody');
      return true;
    } else {
      print('❌ 삭제 실패: ${response.statusCode}');
      print('에러 응답: $responseBody');
      return false;
    }
  }

  // chatRoom 생성
  static Future<ChatRoomModel> createChatRoom({required String uid,required int egoId}) async {
    final uri = Uri.parse('${SettingsService().dbUrl}/chat-room');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'uid': uid, 'egoId' : egoId});

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      final json = utf8.decode(response.bodyBytes); // 한글 깨짐 방지
      final decodedJson = jsonDecode(json);
      final chatRoomModel = ChatRoomModel.fromJson(decodedJson['data']);

      return chatRoomModel;
    } else {
      throw Exception('채팅방 목록 불러오기 실패: ${response.statusCode}');
    }
  }

  // userId와 egoId로 chatroomId를 조회합니다.
  static Future<int> fetchChatRoomIdByEgoIdNuserId(String uid, int egoId) async {
    final uri = Uri.parse('${SettingsService().dbUrl}/chat-room/$uid/$egoId');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final json = utf8.decode(response.bodyBytes); // 한글 깨짐 방지
      final decodedJson = jsonDecode(json);
      final chatRoomId = int.parse(decodedJson['data']['chatRoomId'].toString());

      return chatRoomId;
    } else {
      throw Exception('채팅방 목록 불러오기 실패: ${response.statusCode}');
    }
  }

}
