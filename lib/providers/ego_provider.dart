import 'package:ego/models/ego_model_v1.dart';
import 'package:ego/models/ego_model_v2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ego/services/ego/ego_service.dart';

/**
 * EgoModelV1의 Provider 이후 확정된 모델로 변경
 * */
final egoListProvider = FutureProvider<List<EgoModelV1>>((ref) async {
  return await EgoService.fetchAllEgoList();
});

/**
 * EgoModelV1의 Provider 이후 확정된 모델로 변경
 * */
final egoByIdProvider = FutureProvider.family<EgoModelV1, int>((ref, egoId) async {
  return await EgoService.fetchEgoById(egoId);
});

/**
 * EgoModelV2의 Provider 이후 확정된 모델로 변경
 * */
final egoByIdProviderV2 = FutureProvider.family<EgoModelV2, int>((ref, egoId) async {
  return await EgoService.fetchEgoByIdV2(egoId);
});

/**
 * uid를 기반으로 ego를 조회
 * */
final egoByUserIdProvider = FutureProvider.family<EgoModelV2, String> ((ref, uid) async {
  return await EgoService.fetchEgoByUserId(uid);
});

/**
 * uid를 기반으로 ego의 전체 정보 조회 PsersonalityId를 조회하기 위함
 * */
final fullEgoByUserIdProvider = FutureProvider.family<EgoModelV2, String> ((ref, uid) async {

  final userEgo = await EgoService.fetchEgoByUserId(uid);
  final ego = await ref.watch(egoByIdProviderV2(userEgo.id!).future);

  return ego;
});