import 'package:ego/models/ego_model_v1.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ego/services/ego/ego_service.dart';

final egoListProvider = FutureProvider<List<EgoModelV1>>((ref) async {
  return await EgoService.fetchAllEgoList();
});

final egoByIdProvider = FutureProvider.family<EgoModelV1, int>((ref, egoId) async {
  return await EgoService.fetchEgoById(egoId);
});