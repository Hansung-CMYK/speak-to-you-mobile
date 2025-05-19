import 'package:ego/models/diary/diary.dart';
import 'package:ego/screens/diary/share_one_diary.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

/**
 * 일기 한 화면에 보여지는 TopicContainer
 * */
class TopicContainer extends StatefulWidget {
  final Topic topic;
  final int containerId;

  TopicContainer({Key? key, required this.topic, required this.containerId})
    : super(key: key);

  @override
  _TopicContainerState createState() => _TopicContainerState();
}

class _TopicContainerState extends State<TopicContainer> {
  int cnt = 4; // 이미지 재생성 횟수

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    Topic topic = widget.topic;
    int containerId = widget.containerId;

    return Container(
      key: Key('DiaryContainer_${containerId}'),
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 일기 이미지 부분
          LayoutBuilder(
            builder: (context, constraints) {
              double size = constraints.maxWidth;

              return Container(
                margin: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(topic.url), // 이미지 보이기
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              );
            },
          ),

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
                    topic.title,
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
                      final customToast = CustomToast(
                        toastMsg: '하나의 일기가 공유되었습니다.',
                        iconPath: 'assets/icon/complete.svg',
                        backgroundColor: AppColors.accent,
                        fontColor: AppColors.white,
                      );
                      customToast.init(fToast);

                      shareOneDiary('하나의 일기 공유', customToast);
                    },
                  ),
                ),
              ],
            ),
          ),

          // 내용
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.only(bottom: 40.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.gray300),
              ),
            ),
            child: Text(
              topic.content,
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
}
