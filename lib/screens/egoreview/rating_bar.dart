import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  const StarRating({super.key});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  double rating = 0;  // 별의 수를 결정하는 변수
  int filledStars = 0;  // 채워진 별의 개수

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          double width = MediaQuery.of(context).size.width;
          rating = (details.localPosition.dx / width) * 5;  // 화면 너비를 기준으로 드래그 비율을 계산
          filledStars = rating.round();  // 반올림하여 채워진 별의 개수 계산
        });
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          rating = filledStars.toDouble();  // 드래그가 끝난 후 최종 별의 수 설정
        });
      },
      child: GestureDetector(
        onTapDown: (details) {
          setState(() {
            double width = MediaQuery.of(context).size.width;
            // 클릭한 위치에 해당하는 별의 개수 계산
            rating = (details.localPosition.dx / width) * 5;
            filledStars = rating.round()+1;  // 반올림하여 채워진 별의 개수 계산
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Icon(
              index < filledStars ? Icons.star : Icons.star_border,
              size: 50,
              color: index < filledStars ? Colors.yellow : Colors.grey,
            );
          }),
        ),
      ),
    );
  }
}
