import 'package:ego/models/ego_model_v2.dart';
import 'package:ego/services/ego/ego_service.dart';
import 'package:ego/theme/color.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';

import 'tutorial/ego_information_injection.dart';

class EgoEditScreen extends StatefulWidget {
  const EgoEditScreen({super.key});

  @override
  State<EgoEditScreen> createState() => _EgoEditScreenState();
}

class _EgoEditScreenState extends State<EgoEditScreen> {
  late final EgoModelV2 myEgoModel;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _egoIntroController = TextEditingController();

  bool isNameEmpty = false;
  bool isIntroEmpty = false;

  String selectedMBTI = '';

  Uint8List? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List bytes = await image.readAsBytes();
      setState(() {
        selectedImage = bytes;
        myEgoModel.profileImage = bytes; // 이미지 전송 또는 저장용
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = '';
    _egoIntroController.text = '';
    selectedMBTI = 'INFJ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'EGO 수정하기',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),
        ),
        leading: IconButton(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 3.w),
          constraints: BoxConstraints(),
          icon: SvgPicture.asset(
            'assets/icon/arrow_back.svg',
            width: 18.w,
            height: 16.h,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 100.r,
                                backgroundColor: AppColors.white,
                                child:
                                    selectedImage != null
                                        ? ClipOval(
                                          child: Image.memory(
                                            selectedImage!,
                                            width: 200.r,
                                            height: 200.r,
                                            fit: BoxFit.cover,
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Image.asset(
                                                'assets/image/ego_icon.png',
                                                width: 200.r,
                                                height: 200.r,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        )
                                        : Image.asset(
                                          'assets/image/ego_icon.png',
                                          width: 200.r,
                                          height: 200.r,
                                          fit: BoxFit.cover,
                                        ),
                              ),
                              Container(
                                width: 48.w,
                                height: 48.h,
                                decoration: ShapeDecoration(
                                  color: AppColors.gray100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/icon/camera.svg',
                                  ),
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        // EGO 이름 부분
                        SizedBox(height: 20.h),
                        Text(
                          'EGO 이름',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                isNameEmpty
                                    ? AppColors.errorDark
                                    : AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextField(
                            controller: _nameController,
                            maxLength: 10,
                            onChanged: (text) {
                              setState(() {
                                isNameEmpty = text.isEmpty;
                              });
                            },
                            decoration: _getInputDecoration('EGO 이름 입력'),
                          ),
                        ),

                        // MBTI DropDownMenu 부분
                        SizedBox(height: 10.h),
                        Text(
                          'MBTI',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: SizedBox(
                            width: double.infinity,
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              value: selectedMBTI,
                              items:
                                  [
                                        "INTJ",
                                        "INTP",
                                        "ENTJ",
                                        "ENTP",
                                        "INFJ",
                                        "INFP",
                                        "ENFJ",
                                        "ENFP",
                                        "ISTJ",
                                        "ISFJ",
                                        "ESTJ",
                                        "ESFJ",
                                        "ISTP",
                                        "ISFP",
                                        "ESTP",
                                        "ESFP",
                                      ]
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedMBTI = value!;
                                });
                              },
                              underline: SizedBox(),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: AppColors.gray100,
                                ),
                              ),
                              buttonStyleData: ButtonStyleData(
                                height: 60.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColors.gray200),
                                  color: AppColors.gray100,
                                ),
                              ),
                              hint: Text(
                                'MBTI 선택',
                                style: TextStyle(color: AppColors.gray300),
                              ),
                            ),
                          ),
                        ),

                        // 소개글 부분
                        SizedBox(height: 24.h),
                        Text(
                          'EGO 소개글',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                isIntroEmpty
                                    ? AppColors.errorDark
                                    : AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextFormField(
                            controller: _egoIntroController,
                            maxLines: 3,
                            maxLength: 100,
                            decoration: _getInputDecoration('EGO 소개 작성'),
                            onChanged: (text) {
                              setState(() {
                                isIntroEmpty = text.isEmpty;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 완료 버튼 부분
                  _editCompleteBtn(!isIntroEmpty && !isNameEmpty, () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => UserInfoOnboardingScreen(
                              egoModelV2: myEgoModel,
                              onOnboardingComplete: () {},
                            ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// TextFeild의 테마
///
/// hintText : 무엇을 작성 해야하는 지 사용자에게 알려주는 문구 [String]
InputDecoration _getInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: AppColors.gray300),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.gray200, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.gray200, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    filled: true,
    fillColor: AppColors.gray100,
  );
}

/// 완료 버튼
///
/// isEnable : 완료 버튼의 활성화 여부 [bool]
/// confirm : 버튼 클릭시 동작 [VoidCallback]
Widget _editCompleteBtn(bool isEnable, VoidCallback confirm) {
  return Container(
    width: double.infinity,
    child: TextButton(
      onPressed: isEnable ? confirm : null,
      // Disable button if isEnable is false
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        backgroundColor: isEnable ? AppColors.deepPrimary : AppColors.gray300,
      ),
      child: Text(
        "완료",
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
