import 'package:ego/models/chat/chat_room_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ego/services/chat/chat_room_service.dart';

final chatRoomProvider = FutureProvider.family<List<ChatRoomModel>, String>((ref, uid) async {
  return await ChatRoomService.fetchChatRoomList(
    uid: uid,
    pageNum: 0,
    pageSize: 11,
  );
});