import 'package:ego/models/ego_info_model.dart';
import 'package:flutter_test/flutter_test.dart';

/// 임시 EGO Model 테스트 입니다.
///
void main() {
  group('EGO Model Test / ', () {
    // 임시 test 객체
    final egoInfoModel = EgoInfoModel(
      id: '1',
      egoIcon: '',
      egoName: 'Power',
      egoBirth: '2025/03/12',
      egoPersonality: '착함, 활발',
      egoSelfIntro: '안녕, 나는 Test EGO야',
    );

    test('toJson() 테스트', () {
      final expectedJson = {
        'id': '1',
        'egoIcon': '',
        'egoName': 'Power',
        'egoBirth': '2025/03/12',
        'egoPersonality': '착함, 활발',
        'egoSelfIntro': '안녕, 나는 Test EGO야',
      };

      expect(egoInfoModel.toJson(), equals(expectedJson));
    });

    test('fromJson() 테스트', () {
      final ego = EgoInfoModel.fromJson(egoInfoModel.toJson());

      expect(ego.id, '1');
      expect(ego.egoIcon, '');
      expect(ego.egoName, 'Power');
      expect(ego.egoBirth, '2025/03/12');
      expect(ego.egoPersonality, '착함, 활발');
      expect(ego.egoSelfIntro, '안녕, 나는 Test EGO야');
    });

    test('EGO 생성일로부터 현재 날짜', () {
      expect(egoInfoModel.calcRemainingDays(), 1);
    });
  });
}
