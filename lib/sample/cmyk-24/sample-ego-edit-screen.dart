// import 'package:ego/models/ego_info_model.dart';
// import 'package:ego/models/ego_model_v2.dart';
// import 'package:ego/screens/ego_edit_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../theme/theme.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(393, 852),
//       builder:
//           (context, child) => MaterialApp(
//             title: 'EGO Edit Test',
//             debugShowCheckedModeBanner: false,
//             theme: AppTheme.lightTheme,
//             darkTheme: AppTheme.darkTheme,
//             home: SampleHomeScreen(),
//           ),
//     );
//   }
// }
//
// class SampleHomeScreen extends StatelessWidget {
//   EgoModelV2 egoModelV2 = EgoModelV2(name: '사과', introduction: '나는 사과얌', mbti: 'INFJ');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('홈 화면')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder:
//                     (context) => EgoEditScreen(myEgoInfoModel: egoModelV2),
//               ),
//             );
//           },
//           child: const Text('EGO 수정 화면으로 이동'),
//         ),
//       ),
//     );
//   }
// }
