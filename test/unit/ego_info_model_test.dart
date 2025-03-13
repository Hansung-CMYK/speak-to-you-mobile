import 'package:ego/models/ego_info_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

/// 임시 EGO Model 테스트 입니다.
///
void main() {
  group('EGO Model Test / ', () {
    // 임시 test 객체
    final egoInfoModel = EgoInfoModel(
      id: '1',
      egoIcon: '',
      egoName: 'Power',
      egoBirth: DateFormat('yyyy/MM/dd').format(DateTime.now().add(Duration(days: 0))),
      egoPersonality: '착함, 활발',
      egoSelfIntro: '안녕, 나는 Test EGO야',
    );

    /// 'EgoInfoModel_Serialization_MatchesExpectedValues' 테스트 시나리오
    ///
    /// 위에서 정의한 egoInfoModel이 직렬화가 잘 이루어지는지 확인
    test('EgoInfoModel_Serialization_MatchesExpectedValues', () {
      final expectedJson = {
        'id': '1',
        'egoIcon': '',
        'egoName': 'Power',
        'egoBirth': DateFormat('yyyy/MM/dd').format(DateTime.now()),
        'egoPersonality': '착함, 활발',
        'egoSelfIntro': '안녕, 나는 Test EGO야',
      };

      expect(egoInfoModel.toJson(), equals(expectedJson));
    });

    /// 'EgoInfoModel_Deserialization_MatchesExpectedValues' 테스트 시나리오
    ///
    /// 위에서 정의한 egoInfoModel이 역직렬화가 잘 이루어지는지 확인
    test('EgoInfoModel_Deserialization_MatchesExpectedValues', () {
      final ego = EgoInfoModel.fromJson(egoInfoModel.toJson());

      expect(ego.id, '1');
      expect(ego.egoIcon, '');
      expect(ego.egoName, 'Power');
      expect(ego.egoBirth, DateFormat('yyyy/MM/dd').format(DateTime.now()));
      expect(ego.egoPersonality, '착함, 활발');
      expect(ego.egoSelfIntro, '안녕, 나는 Test EGO야');
    });

    /// 'calcRemainingDays_fromToday_zero' 테스트 시나리오
    ///
    /// 오늘이 EGO의 생일인 경우 D-0이 나와냐 하므로 expect 값을 0으로 설정
    test('calcRemainingDays_fromToday_zero', () {
      expect(egoInfoModel.calcRemainingDays(), 0);
    });
  });
}
