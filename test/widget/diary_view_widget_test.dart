import 'package:ego/sample/cmyk-18/sample-diary-view-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Diary View Screen을  띄우기 위한 버튼이 있는지 확인
  testWidgets('Diary View Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const DiaryViewApp());

    final gotoDiaryViewButton = find.text('Diary 화면으로 이동');

    expect(gotoDiaryViewButton, findsOneWidget);
  });

  // Diary View Screen을 띄우기
  testWidgets('Goto Diary View Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const DiaryViewApp());

    // 화면 이동 버튼 찾기
    final gotoDiaryViewButton = find.text('Diary 화면으로 이동');

    // 화면 이동 버튼 클릭
    await tester.tap(gotoDiaryViewButton);

    // 에니메이션 또는 화면 렌더링이 끝날때 까지 대기
    await tester.pumpAndSettle();

    // '일기보기' title이 있는지 확인 - 화면이 정상적으로 띄워 졌는지 확인하기 위함
    expect(find.text('일기보기'), findsOneWidget);
  });

  // 이미지 재생성시 횟수가 바뀌는지 확인하기 위함
  testWidgets('Goto Diary View Screen', (WidgetTester tester) async {
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

    // 4회 이상 눌렀을 때 숫자가 음수가 되는지 확인하기 위함
    for (int i = 0; i < 5; i++) {
      await tester.ensureVisible(reGenBtn);
      await tester.pumpAndSettle();
      await tester.tap(reGenBtn);
    }

    expect(tester.widget<Text>(reGenCnt).data, '0P');
  });
}
