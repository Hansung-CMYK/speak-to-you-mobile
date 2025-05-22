import 'package:ego/models/diary/diary.dart';
import 'package:ego/providers/diary/diary_image_provider.dart';
import 'package:ego/screens/diary/share_one_diary.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

/**
 * 일기 한 화면에 보여지는 TopicContainer
 * */
class TopicContainer extends ConsumerStatefulWidget {
  final Topic topic;
  final int containerId;
  final int regenerateKey;
  final VoidCallback onRegenerateKeyChanged;


  TopicContainer({
    Key? key,
    required this.topic,
    required this.containerId,
    required this.regenerateKey,
    required this.onRegenerateKeyChanged,
  }) : super(key: key);

  @override
  _TopicContainerState createState() => _TopicContainerState();
}

class _TopicContainerState extends ConsumerState<TopicContainer> {
  int cnt = 4; // 이미지 재생성 횟수
  late String fixedPrompt;

  late PageController _pageController;
  List<String> imageUrls = [];
  int currentPage = 0;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialImage();
    });
  }

  Future<void> _loadInitialImage() async {
    fixedPrompt = widget.topic.content;
    widget.onRegenerateKeyChanged();
    final imageUrl = await ref.read(
      diaryImageProvider((
        prompt: fixedPrompt,
        regenerateKey: widget.regenerateKey,
      )).future,
    );
    setState(() {
      imageUrls.add(imageUrl);
    });
  }

  void _regenerateImage() async {
    if (cnt > 0) {
      setState(() {
        cnt--;
      });
      fixedPrompt = widget.topic.content;
      widget.onRegenerateKeyChanged();
      final imageUrl = await ref.read(
        diaryImageProvider((
          prompt: fixedPrompt,
          regenerateKey: widget.regenerateKey,
        )).future,
      );
      setState(() {
        imageUrls.add(imageUrl);
        currentPage = imageUrls.length - 1;
        _pageController.jumpToPage(currentPage);
      });
      print('containerID : $widget.containerId');
      print('📸 Prompt: $fixedPrompt');
      print('🧬 Key: ${widget.regenerateKey}');
      print('🌐 Image URL: $imageUrl');
    } else {
      // TODO: 재생성 횟수 초과 처리
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                width: size,
                height: size,
                child:
                    imageUrls.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : PageView.builder(
                          controller: _pageController,
                          itemCount: imageUrls.length,
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(imageUrls[index]),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            );
                          },
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
                  onPressed: _regenerateImage,
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
