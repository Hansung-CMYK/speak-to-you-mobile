import 'dart:convert';

import 'package:ego/theme/color.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;

import 'test_diary_view_screen.dart';

class DiaryContainer extends StatefulWidget {
  final Diary diary;
  final int containerId;

  DiaryContainer({Key? key, required this.diary, required this.containerId}) : super(key: key);

  @override
  _DiaryContainerState createState() => _DiaryContainerState();
}

class _DiaryContainerState extends State<DiaryContainer> {
  int cnt = 4; // 이미지 재생성 횟수
  String? randomImageUrl;

  @override
  void initState() {
    super.initState();
    randomImageUrl = null;
  }

  @override
  Widget build(BuildContext context) {
    Diary diary = widget.diary;
    int containerId = widget.containerId;

    return Container(
      key: Key('DiaryContainer_${containerId}'),
      padding: EdgeInsets.symmetric(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 일기 이미지 부분
          LayoutBuilder(builder: (context, constraints) {
            double size = constraints.maxWidth;

            return Container(
              key: Key('ImageContainer_${containerId}'),
              margin: EdgeInsets.only(bottom: 10.h),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: randomImageUrl != null
                        ? NetworkImage(randomImageUrl!) // 변경된 이미지
                        : AssetImage(diary.image) as ImageProvider, // 기본 로컬 이미지
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            );
          }),

          // 이미지 재생성 횟수, 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 횟수
              Container(
                child: Text(
                  key: Key('RegenCnt_${containerId}'),
                  '${cnt}P',
                  style: TextStyle(
                    color: AppColors.gray400,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Container(
                height: 16.h,
                child: VerticalDivider(thickness: 1, color: AppColors.gray200),
              ),
              // 버튼
              Container(
                width: 16.w,
                height: 16.h,
                child: IconButton(
                  key: Key('RegenImgBtn_${containerId}'),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (cnt > 0) {
                      cnt--;
                      fetchRandomCocktail();
                      setState(() {});
                    } else {
                      // TODO 횟수 다 사용했을 때 처리 (필요시 메시지 등 추가)
                    }
                  },
                  icon: SvgPicture.asset(
                    'assets/icon/image_regen.svg',
                    width: 16.w,
                    height: 16.h,
                  ),
                ),
              ),
            ],
          ),

          // 일기 주제 및 공유 버튼
          Padding(
            padding: EdgeInsets.only(bottom: 8.h, top: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 일기 주제
                Container(
                  child: Text(
                    diary.title,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // 일기 공유 버튼
                Container(
                  padding: EdgeInsets.only(right: 8.w),
                  width: 24.w,
                  height: 24.h,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      'assets/icon/share_icon.svg',
                      width: 14.w,
                      height: 14.h,
                    ),
                    onPressed: () {
                      // TODO 해당 주제만 공유
                    },
                  ),
                ),
              ],
            ),
          ),

          // 내용
          Container(
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.only(bottom: 40.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.gray300),
              ),
            ),
            child: Text(
              diary.content,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 임시 호출 API (이미지 URL을 반환)
  Future<void> fetchRandomCocktail() async {
    final url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php';

    try {
      // GET 방식으로 API 호출
      final response = await http.get(Uri.parse(url));

      // 응답이 성공적인 경우
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          randomImageUrl = data['drinks'][0]['strDrinkThumb'];
        });
      } else {
        print('API 호출 실패, 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      print('API 호출 중 에러 발생: $e');
    }
  }
}
