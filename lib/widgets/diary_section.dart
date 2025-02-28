import 'package:ego/theme/color.dart';
import 'package:ego/utils/constants.dart';
import 'package:ego/widgets/diarycard/diary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiarySection extends StatefulWidget {
  final int filterIndex;
  final int diaryCount;
  const DiarySection({
    super.key,
    required this.filterIndex,
    required this.diaryCount,
  });

  @override
  State<DiarySection> createState() => _DiarySectionState();
}

class _DiarySectionState extends State<DiarySection> {
  final List<String> sortOptions = ['최신순', '오래된순'];
  String _selectedSortOption = '최신순';

  // 필터 인덱스를 Emotion enum 값으로 매핑 (constants.dart에 정의되어 있다고 가정)
  Emotion getEmotionFromIndex(int index) {
    switch (index) {
      case 0:
        return Emotion.anger;
      case 1:
        return Emotion.sadness;
      case 2:
        return Emotion.happiness;
      case 3:
        return Emotion.disappointment;
      case 4:
        return Emotion.embarrassment;
      default:
        throw Exception('Invalid filter index');
    }
  }

  @override
  Widget build(BuildContext context) {
    Emotion emotion = getEmotionFromIndex(widget.filterIndex);

    // diaryCount가 0이면 해당 감정의 일기가 없다는 메시지 출력
    if (widget.diaryCount <= 0) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: Text(
            '해당 감정의 일기가 없어요!',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.gray300,
            ),
          ),
        ),
      );
    }

    // 전달받은 diaryCount 만큼 DiaryCard를 동적으로 생성
    List<DiaryCard> diaryCards = List.generate(widget.diaryCount, (i) {
      DateTime date = DateTime.now().subtract(Duration(days: i));
      return DiaryCard(
        date: date,
        emotions: [emotion],
        egoName: 'Diary ${i + 1}',
        story: '$emotion 일기 내용 ${i + 1}',
      );
    });

    // 정렬 옵션에 따라 DiaryCard 정렬
    diaryCards.sort((a, b) {
      if (_selectedSortOption == '최신순') {
        return b.date.compareTo(a.date);
      } else {
        return a.date.compareTo(b.date);
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        Align(
          alignment: Alignment.centerRight,
          child: DropdownButton<String>(
            value: _selectedSortOption,
            underline: const SizedBox(),
            isDense: true,
            itemHeight: null,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.gray600,
              size: 16.r,
            ),
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.gray600,
              fontWeight: FontWeight.w500,
            ),
            items:
                sortOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedSortOption = value;
                });
              }
            },
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: diaryCards.length,
          separatorBuilder: (context, index) => SizedBox(height: 4.h),
          itemBuilder: (context, index) {
            return diaryCards[index];
          },
        ),
      ],
    );
  }
}
