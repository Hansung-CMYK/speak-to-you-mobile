import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ex_user_provider.dart';
import '../models/ex_user_model.dart';
import '../services/ex_api_service.dart';

class HomeScreen extends StatelessWidget {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: userProvider.isLoading
            ? CircularProgressIndicator()
            : userProvider.user == null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('사용자 정보 없음'),
            ElevatedButton(
              onPressed: () async {
                userProvider.setLoading(true);
                UserModel? user = await _apiService.fetchUser('1');
                userProvider.setLoading(false);
                if (user != null) {
                  userProvider.setUser(user);
                }
              },
              child: Text('사용자 불러오기'),
            ),
          ],
        )
            : Text('환영합니다, ${userProvider.user!.name}!'),
      ),
    );
  }
}
