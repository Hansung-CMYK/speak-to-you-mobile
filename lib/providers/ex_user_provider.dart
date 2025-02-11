import 'package:flutter/foundation.dart';
import '../models/ex_user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user; // 사용자 정보 저장
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  // 사용자 데이터 업데이트
  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  // 로딩 상태 변경
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
