import 'dart:convert';

import 'package:ego/sample/cmyk-18/sample_diary_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';

void main() {
  group('DiaryViewIntegrationTest/', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('RegenImageBtn_getDiaryImage_isFetchedData', (WidgetTester tester) async {
      await tester.pumpWidget(const DiaryViewApp());

      // 화면 이동 버튼 찾기
      final gotoDiaryViewButton = find.text('Diary 화면으로 이동');

      // 화면 이동 버튼 클릭
      await tester.tap(gotoDiaryViewButton);

      // 에니메이션 또는 화면 렌더링이 끝날때 까지 대기
      await tester.pumpAndSettle();

      // '일기보기' title이 있는지 확인 - 화면이 정상적으로 띄워 졌는지 확인하기 위함
      expect(find.text('일기보기'), findsOneWidget);

      final diaryContainer = find.byKey(Key('DiaryContainer_0'));

      final reGenCnt = find.descendant(
        of: diaryContainer,
        matching: find.byKey(Key('RegenCnt_0')),
      );

      // 초기 cnt 상태가 4P인지 확인하기 위함
      expect(tester.widget<Text>(reGenCnt).data, '4P');

      final reGenBtn = find.descendant(
        of: diaryContainer,
        matching: find.byKey(Key('RegenImgBtn_0')),
      );



    });

  });
}

// EGO 소개 화면 확인 띄워지는 지 확인
// Toast 띄워지는지 확인
