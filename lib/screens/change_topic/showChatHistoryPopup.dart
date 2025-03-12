import 'package:ego/models/chat/chat_content_model.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/button/svg_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 클릭한 주제의 내용을 표시하는 풀스크린 팝업 위젯 반환
///
/// context : popup을 띄우기위함 [BuildContext]
/// topic : 대화 주제 [String]
/// chatMessages : 대화내용 [ChatContentModel]
Widget showChatHistoryPopup(
  BuildContext context,
  String topic,
  List<ChatContentModel> chatMessages,
) {
  // 시간 순으로 정렬
  chatMessages.sort((a, b) => a.time.compareTo(b.time));

  return Dialog(
    insetPadding: EdgeInsets.zero,
    backgroundColor: AppColors.transparent,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: AppColors.white.withValues(alpha: 0.8)),
      child: Stack(
        children: [
          // 팝업 내용 중앙 배치
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 선택한 주제 표시
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Text(
                    topic,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // 채팅방 내용
                Expanded(
                  child: RawScrollbar(
                    thumbVisibility: true,
                    thumbColor: AppColors.gray700,
                    radius: Radius.circular(10.r),
                    thickness: 4.w,
                    padding: EdgeInsets.only(right: 2.w),
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      children:
                          chatMessages.map((message) {
                            bool isUserMessage = message.isUser;
                            return Row(
                              mainAxisAlignment:
                                  isUserMessage
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      isUserMessage
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 4.h,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          if (!isUserMessage) ...[
                                            // 남이 보낸 메시지: 채팅 내용, 시간
                                            Container(
                                              padding: EdgeInsets.all(10.r),
                                              margin: EdgeInsets.only(
                                                bottom: 5.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blueAccent,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 250.w,
                                                ),
                                                child: Text(
                                                  message.content,
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 16.sp,
                                                  ),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              message.getAMPMTime(),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ] else ...[
                                            // 내가 보낸 메시지: 시간, 채팅 내용
                                            Text(
                                              message.getAMPMTime(),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Container(
                                              padding: EdgeInsets.all(10.r),
                                              margin: EdgeInsets.only(
                                                bottom: 5.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 250.w,
                                                ),
                                                child: Text(
                                                  message.content,
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 16.sp,
                                                  ),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 닫기 버튼 우측 상단 배치
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: SvgButton(
                    svgPath: 'assets/icon/close.svg',
                    onTab: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
