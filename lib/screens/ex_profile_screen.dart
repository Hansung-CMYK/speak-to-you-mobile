import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ex_user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return Center(
            child: userProvider.user == null
                ? Text('로그인되지 않음')
                : Text('사용자 이름: ${userProvider.user!.name}'),
          );
        },
      ),
    );
  }
}
