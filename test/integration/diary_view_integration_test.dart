import 'package:ego/sample/cmyk-18/sample_diary_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('DiaryViewIntegrationTest/', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('RegenImageBtn_getDiaryImage_isFetchedData', (
      WidgetTester tester,
    ) async {
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

      // 초기 이미지 생성 횟수(cnt) 상태가 4P인지 확인하기 위함
      expect(tester.widget<Text>(reGenCnt).data, '4P');

      // ImageContainer_0 키를 가진 Container를 찾음
      final imageContainer = find.byKey(Key('ImageContainer_0'));

      // 해당 ImageContainer가 잘 렌더링 되었는지 확인
      expect(imageContainer, findsOneWidget);

      // imageContainer에서 자식 Container를 찾음
      final childContainer = find.descendant(
        of: imageContainer,
        matching: find.byType(Container),
      );

      // 자식 Container 위젯을 가져옴 - 해당 Container는 이미지를 가지고 있음
      final containerWidget = tester.widget<Container>(childContainer);

      // BoxDecoration으로 캐스팅하여 decoration.image를 가져옴
      final BoxDecoration? decoration =
          containerWidget.decoration as BoxDecoration;
      final DecorationImage? decorationImage = decoration?.image;

      // 초기 이미지는 내장 path로 설정 되었는지 확인함
      if (decorationImage?.image is AssetImage) {
        final assetImage = decorationImage!.image as AssetImage;
        expect(
          assetImage.assetName,
          'assets/image/first_diary_sample_image.png',
        );
      }

      // 재생성 버튼을 가져옴
      final reGenBtn = find.descendant(
        of: diaryContainer,
        matching: find.byKey(Key('RegenImgBtn_0')),
      );

      // 이미지 재생성 버튼 클릭
      await tester.ensureVisible(reGenBtn);
      await tester.tap(reGenBtn);
      await tester.pumpAndSettle();

      // 업데이트된 Container
      final updatedChildContainer = find.descendant(
        of: imageContainer,
        matching: find.byType(Container),
      );

      // 업데이트된 ImageContainer
      final updatedContainerWidget = tester.widget<Container>(
        updatedChildContainer,
      );
      final updatedDecoration =
          updatedContainerWidget.decoration as BoxDecoration?;
      final updatedDecorationImage = updatedDecoration?.image;

      // 이미지 URL 출력
      if (updatedDecorationImage?.image is NetworkImage) {
        final NetworkImage networkImage =
            updatedDecorationImage!.image as NetworkImage;
        print('📷 DiaryView의 첫번째 일기 이미지 URL: ${networkImage.url}');
      } else {
        print('❌ NetworkImage가 아닙니다.');
      }
    });
  });
}

// EGO 소개 화면 확인 띄워지는 지 확인
// Toast 띄워지는지 확인
