import 'package:ego/models/ego_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/ego/ego_service.dart';

final egoListProvider = FutureProvider<List<EgoModel>>((ref) async {
  return await EgoService.fetchEgoList();
});
