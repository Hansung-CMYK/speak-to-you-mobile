import 'package:ego/models/ego_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ego/services/ego/ego_service.dart';

final egoListProvider = FutureProvider<List<EgoModel>>((ref) async {
  return await EgoService.fetchAllEgoList();
});

final egoByIdProvider = FutureProvider.family<EgoModel, int>((ref, egoId) async {
  return await EgoService.fetchEgoById(egoId);
});