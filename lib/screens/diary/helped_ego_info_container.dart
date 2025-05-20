import 'package:ego/providers/ego_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ego/theme/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ego/widgets/bottomsheet/today_ego_introV2.dart';

/**
 * 일기 작성을 도와준 EGO의 정보를 보여줍니다.
 * */
class HelpedEgoInfoContainer extends ConsumerWidget {
  final int egoId;

  const HelpedEgoInfoContainer({super.key, required this.egoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // egoId로 Ego정보 요청
    final egoAsync = ref.watch(egoByIdProviderV2(egoId));

    return egoAsync.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        print('에러 발생: $error');
        print('스택트레이스: $stack');
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // 프로바이더 새로고침
                  ref.invalidate(egoByIdProviderV2);
                },
                child: Text('다시 시도'),
              ),
            ],
          ),
        );
      },
      data: (ego) {
        return Container(
          padding: EdgeInsets.only(bottom: 32.h, left: 20.w, right: 20.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '일기를 도와준 친구',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
              ),

              // EGO Profile 이미지 부분
              LayoutBuilder(
                builder: (context, constraints) {
                  double size = constraints.maxWidth;

                  return Container(
                    margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: AppColors.warningBase,
                      image:
                          ego.profileImage != null
                              ? DecorationImage(
                                image: MemoryImage(ego.profileImage!),
                                fit: BoxFit.cover,
                              )
                              : null,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child:
                        ego.profileImage == null
                            ? Center(
                              child: Icon(
                                Icons.person,
                                size: 48.sp,
                                color: AppColors.gray400,
                              ),
                            )
                            : null,
                  );
                },
              ),

              // EGO 이름 + 프로필 상세보기
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ego.name,
                      style: TextStyle(
                        color: AppColors.gray900,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // 클릭 시 동작 EGO BottomSheet 띄우기
                        // 해당 EGO는 평가 수정이 가능해야 함
                        showTodayEgoIntroSheetV2(context, ego, isOtherEgo: true);
                      },
                      child: Row(
                        children: [
                          Text(
                            '프로필 보기',
                            style: TextStyle(
                              color: AppColors.gray400,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          SvgPicture.asset('assets/icon/right_arrow.svg'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
