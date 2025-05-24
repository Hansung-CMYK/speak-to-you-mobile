import 'dart:convert';
import 'package:ego/models/chat/chat_room_model.dart';
import 'package:ego/models/ego_model_v2.dart';
import 'package:ego/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:ego/providers/ego_provider.dart';

class EgoService {
  /**
   * 전달된 ChatRoomModel들을 바탕으로 EGO정보를 조회합니다.
   * */
  static Future<List<EgoModelV2>> fetchEgoModelsForChatRooms(
    List<ChatRoomModel> chatRoomList,
    WidgetRef ref,
  ) async {
    // 각 chatRoom에 대한 egoId를 기반으로 egoModel Future 리스트 생성
    final futures =
        chatRoomList
            .map(
              (chatRoom) => ref.watch(
                egoByIdProviderV2(chatRoom.egoId).future,
              ), // egoId로 EgoModel 가져오기
            )
            .toList();

    // 여러 개의 future를 기다리기 위해 Future.wait 사용
    return await Future.wait(futures);
  }

  /**
   * 스피크 화면에서 EGO list를 불러올때 사용 됩니다.
   * */
  static Future<List<EgoModelV2>> fetchEgoModelsFromChatRoomsWithoutRef(
      List<ChatRoomModel> chatRoomList,
      ) async {
    // 각 chatRoom의 egoId를 사용하여 직접 API 호출
    final futures = chatRoomList.map((chatRoom) {
      return EgoService.fetchEgoByIdV2(chatRoom.egoId);
    }).toList();

    return await Future.wait(futures);
  }


  /**
   * EgoModelV2의 Provider 이후 확정된 모델로 변경
   * */
  static Future<EgoModelV2> fetchEgoByIdV2(int egoId) async {
    final response = await http.get(Uri.parse('$baseUrl/ego/$egoId'));

    if (response.statusCode == 200) {
      // response.body 대신 bodyBytes 사용하여 UTF-8로 디코딩
      final json = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> decodedJson = jsonDecode(json);

      final egoData = decodedJson['data'];

      // 데이터를 EgoModel로 변환하여 반환
      return EgoModelV2.fromJson(egoData);
    } else {
      throw Exception('Ego 정보 불러오기 실패: ${response.statusCode}');
    }
  }

  /**
   * 사용자 id로 사용자의 ego조회
   * */
  static Future<EgoModelV2> fetchEgoByUserId(String uid) async {
    final response = await http.get(Uri.parse('$baseUrl/ego/user/$uid'));

    if (response.statusCode == 200) {
      final json = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> decodedJson = jsonDecode(json);

      final egoData = decodedJson['data'];

      return EgoModelV2.fromJson(egoData);
    } else {
      throw Exception('Ego 정보 불러오기 실패: ${response.statusCode}');
    }
  }

  /**
   * ego정보를 조회하되, 현재 로그인한 사용자가 평가한 점수를 같이 조회 합니다.
   * */
  static Future<EgoModelV2> fetchOtherEgoByUserIdWithRating(String otherUid) async {
    final otherEgoData = await fetchEgoByUserId(otherUid); // uid로 상대의 ego 조회
    String uid = 'uid2'; //uid는 시스템에 존재
    final otherEgoRating = await http.get(Uri.parse('$baseUrl/ego/${otherEgoData.id}/$uid')); // 내(현 시스템 사용자)가 다른 ego를 어떤식으로 평가했는지 값

    if(otherEgoRating.statusCode == 200){

      final json = utf8.decode(otherEgoRating.bodyBytes);
      final Map<String, dynamic> decodedJson = jsonDecode(json);

      final ratingNpersonality = decodedJson['data'];

      otherEgoData.rating = ratingNpersonality['rating'];
      otherEgoData.personalityList = List<String>.from(ratingNpersonality['personalityList']);

      return otherEgoData;
    } else{
      throw Exception('Ego 정보 및 personalityList, rating 조회 실패 : ${otherEgoRating.statusCode}');
    }


  }

}
