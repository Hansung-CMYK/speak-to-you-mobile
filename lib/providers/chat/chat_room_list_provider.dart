import 'package:ego/services/ego/ego_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/chat/chat_room_list_model.dart';
import 'chat_room_provider.dart';

final chatRoomListModelProvider = FutureProvider.family<List<ChatRoomListModel>, String>((ref, uid) async {
  final chatRoomList = await ref.watch(chatRoomProvider(uid).future);

  final egoList = await Future.wait(
    chatRoomList.map((chatRoom) => EgoService.fetchEgoById(chatRoom.egoId)),
  );

  final chatRoomListModels = <ChatRoomListModel>[];

  for (int i = 0; i < chatRoomList.length; i++) {
    final chatRoom = chatRoomList[i];
    final egoModel = egoList[i];

    // ✅ ChatRoomListModel 생성
    chatRoomListModels.add(ChatRoomListModel(
      id: chatRoom.id,
      uid: chatRoom.uid,
      egoId: chatRoom.egoId,
      lastChatAt: chatRoom.lastChatAt,
      isDeleted: chatRoom.isDeleted,
      egoName: egoModel.name,
      profileImage: egoModel.profileImage,
    ));
  }

  return chatRoomListModels;
});
