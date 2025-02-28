import 'package:ego/theme/color.dart';
import 'package:flutter/cupertino.dart';

class EmotionFilter extends StatefulWidget {
  const EmotionFilter({super.key});

  @override
  State<EmotionFilter> createState() => _EmotionFilterState();
}

class _EmotionFilterState extends State<EmotionFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353,
      height: 122,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 353,
              height: 122,
              decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Positioned(
            left: 17.50,
            top: 20,
            child: Container(
              width: 318,
              height: 72,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 54,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 43,
                          height: 46,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0.50,
                                top: 6,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 8.52,
                                        top: 11.94,
                                        child: Container(
                                          width: 22.95,
                                          height: 15.85,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 22.95,
                                                  height: 7.20,
                                                  child: Stack(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 21,
                                top: 0,
                                child: Container(
                                  width: 22,
                                  height: 13,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFF4D4F),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Color(0xFFF7F8F9),
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                '2',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 10,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.60,
                                                  letterSpacing: -0.50,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 48,
                          child: SizedBox(
                            width: 48,
                            child: Text(
                              '분노',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                                letterSpacing: -0.60,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 54,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 43,
                          height: 46,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0.50,
                                top: 6,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 1.91,
                                        top: 9.68,
                                        child: Container(
                                          width: 36.17,
                                          height: 26.65,
                                          child: Stack(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 21,
                                top: 0,
                                child: Container(
                                  width: 22,
                                  height: 13,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFF4D4F),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Color(0xFFF7F8F9),
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                '1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 10,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.60,
                                                  letterSpacing: -0.50,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 48,
                          child: SizedBox(
                            width: 48,
                            child: Text(
                              '슬픔',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                                letterSpacing: -0.60,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 54,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 43,
                          height: 44,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0.50,
                                top: 4,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 0,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 5.52,
                                        top: 13.38,
                                        child: Container(
                                          height: 14.14,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0.58,
                                                top: 0,
                                                child: Container(
                                                  width: 27.24,
                                                  height: 3.05,
                                                  child: Stack(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 21,
                                top: 0,
                                child: Container(
                                  width: 22,
                                  height: 13,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFF4D4F),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Color(0xFFF7F8F9),
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                '99',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 10,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.60,
                                                  letterSpacing: -0.50,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 48,
                                child: SizedBox(
                                  width: 48,
                                  child: Text(
                                    '기쁨',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 1.50,
                                      letterSpacing: -0.60,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 54,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 0.50,
                            right: 3.50,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 31.58,
                                      height: 19.03,
                                      child: Stack(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 48,
                          child: SizedBox(
                            width: 48,
                            child: Text(
                              '실망',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                                letterSpacing: -0.60,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 54,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 46,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0.50,
                                top: 6,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 6.07,
                                        top: 8.17,
                                        child: Container(
                                          height: 20.35,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 29.19,
                                                  height: 14.20,
                                                  child: Stack(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 22,
                                top: 0,
                                child: Container(
                                  width: 22,
                                  height: 13,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFF4D4F),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Color(0xFFF7F8F9),
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                '1',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 10,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.60,
                                                  letterSpacing: -0.50,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 48,
                          child: SizedBox(
                            width: 48,
                            child: Text(
                              '황당',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.50,
                                letterSpacing: -0.60,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 157,
            top: 106,
            child: Container(
              width: 40,
              height: 4,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: Color(0xFFE8EBED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 24,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: Color(0xFF454C53),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
