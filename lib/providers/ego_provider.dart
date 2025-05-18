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