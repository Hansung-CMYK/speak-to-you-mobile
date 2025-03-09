import 'package:ego/theme/color.dart';
import 'package:ego/theme/theme.dart';
import 'package:ego/widgets/button/radius_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder:
          (context, child) => MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: Scaffold(
              appBar: AppBar(
                actionsPadding: EdgeInsets.symmetric(horizontal: 16.w),
                centerTitle: true,
                surfaceTintColor: AppColors.white,
                actions: [
                  GestureDetector(
                    onTap: () => {},
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icon/close.svg',
                        height: 24.r,
                        width: 24.r,
                      ),
                    ),
                  ),
                ],
                title: Text(
                  '서비스 이용약관',
                  style: TextStyle(
                    color: AppColors.gray900,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  color: AppColors.gray100,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w,
                      vertical: 24.0.h,
                    ),
                    child: Html(
                      data: """
        <h4>제 1 장 환영합니다!</h4>
        <h5>제 1 조(목적)</h5>
        <p>주식회사 카카오(이하 ‘회사’)가 제공하는 서비스를 이용해 주셔서 감사합니다. 회사는 여러분이 다양한 인터넷과 모바일 서비스를 좀 더 편리하게 이용할 수 있도록 회사 또는 관계사의 개별 서비스에 모두 접속 가능한 통합로그인 계정 체계를 만들고 그에 적용되는 '카카오계정 약관(이하 '본 약관')을 마련하였습니다. 본 약관은 여러분이 카카오 계정 서비스를 이용하는 데 필요한 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정하고 있으므로 조금만 시간을 내서 주의 깊게 읽어주시기 바랍니다.</p>
        <p>주식회사 카카오(이하 ‘회사’)가 제공하는 서비스를 이용해 주셔서 감사합니다. 회사는 여러분이 다양한 인터넷과 모바일 서비스를 좀 더 편리하게 이용할 수 있도록 회사 또는 관계사의 개별 서비스에 모두 접속 가능한 통합로그인 계정 체계를 만들고 그에 적용되는 '카카오계정 약관(이하 '본 약관')을 마련하였습니다. 본 약관은 여러분이 카카오 계정 서비스를 이용하는 데 필요한 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정하고 있으므로 조금만 시간을 내서 주의 깊게 읽어주시기 바랍니다.</p>
        <p>주식회사 카카오(이하 ‘회사’)가 제공하는 서비스를 이용해 주셔서 감사합니다. 회사는 여러분이 다양한 인터넷과 모바일 서비스를 좀 더 편리하게 이용할 수 있도록 회사 또는 관계사의 개별 서비스에 모두 접속 가능한 통합로그인 계정 체계를 만들고 그에 적용되는 '카카오계정 약관(이하 '본 약관')을 마련하였습니다. 본 약관은 여러분이 카카오 계정 서비스를 이용하는 데 필요한 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정하고 있으므로 조금만 시간을 내서 주의 깊게 읽어주시기 바랍니다.</p>
        <p>주식회사 카카오(이하 ‘회사’)가 제공하는 서비스를 이용해 주셔서 감사합니다. 회사는 여러분이 다양한 인터넷과 모바일 서비스를 좀 더 편리하게 이용할 수 있도록 회사 또는 관계사의 개별 서비스에 모두 접속 가능한 통합로그인 계정 체계를 만들고 그에 적용되는 '카카오계정 약관(이하 '본 약관')을 마련하였습니다. 본 약관은 여러분이 카카오 계정 서비스를 이용하는 데 필요한 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정하고 있으므로 조금만 시간을 내서 주의 깊게 읽어주시기 바랍니다.</p>
        <p>주식회사 카카오(이하 ‘회사’)가 제공하는 서비스를 이용해 주셔서 감사합니다. 회사는 여러분이 다양한 인터넷과 모바일 서비스를 좀 더 편리하게 이용할 수 있도록 회사 또는 관계사의 개별 서비스에 모두 접속 가능한 통합로그인 계정 체계를 만들고 그에 적용되는 '카카오계정 약관(이하 '본 약관')을 마련하였습니다. 본 약관은 여러분이 카카오 계정 서비스를 이용하는 데 필요한 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정하고 있으므로 조금만 시간을 내서 주의 깊게 읽어주시기 바랍니다.</p>
        <p>주식회사 카카오(이하 ‘회사’)가 제공하는 서비스를 이용해 주셔서 감사합니다. 회사는 여러분이 다양한 인터넷과 모바일 서비스를 좀 더 편리하게 이용할 수 있도록 회사 또는 관계사의 개별 서비스에 모두 접속 가능한 통합로그인 계정 체계를 만들고 그에 적용되는 '카카오계정 약관(이하 '본 약관')을 마련하였습니다. 본 약관은 여러분이 카카오 계정 서비스를 이용하는 데 필요한 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정하고 있으므로 조금만 시간을 내서 주의 깊게 읽어주시기 바랍니다.</p>
        
        """,
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                color: AppColors.gray100,
                //상단 패딩은 임시로 잡아두었음
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 43.h),
                  child: RadiusButton(
                    text: '확인',
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.primary,
                    confirmMethod: () => {},
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
