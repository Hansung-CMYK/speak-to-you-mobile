/// 다이얼로그 타입을 관리하는 enum
/// - info: 정보성 다이얼로그
/// - success: 성공 메시지 다이얼로그
enum DialogType { info, success, danger }

/// DialogType에 따라 다른 SVG 에셋 파일 경로를 반환하는 Extension
extension DialogTypeExtension on DialogType {
  String get asset {
    switch (this) {
      case DialogType.info:
        return 'assets/icon/info.svg';
      case DialogType.success:
        return 'assets/icon/success.svg';
      case DialogType.danger:
        return 'assets/icon/danger.svg';
    }
  }
}
