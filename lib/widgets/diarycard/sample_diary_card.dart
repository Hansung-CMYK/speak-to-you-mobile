import 'package:flutter/cupertino.dart';
import '../../theme/color.dart';

class SampleDiaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353,
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8, left: 12, right: 16, bottom: 8),
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(1.00, 0.00),
                end: Alignment(-1, 0),
                colors: [Color(0xFFFEAC5E), Color(0xFFE6968D), Color(0xFFC779D0), Color(0xFF5865F2)],
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 24,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/24x24"), // TODO: 웃는 얼굴
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(
                              side: BorderSide(width: 2, color: AppColors.white), // TODO: 이미지 테두리
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '2025년 01월10일',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                            letterSpacing: -0.70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 45),
                Container( // TODO: 영상 아이콘
                  width: 24,
                  height: 24,
                  child: Stack(),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 자동 크기 조정
              mainAxisAlignment: MainAxisAlignment.start, // 중앙 정렬 제거
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EGO 이름',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                    letterSpacing: -0.70,
                  ),
                ),
                const SizedBox(height: 4),
                Flexible( // Expanded 대신 Flexible 사용
                  child: Text(
                    '요약된 일기 내용을 보여줍니다. 이날은 무슨 일이 있었고, 어쩌고 저쩌고... 이러쿵 저러쿵... 이야기를 작성한다...',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                      letterSpacing: -0.70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
