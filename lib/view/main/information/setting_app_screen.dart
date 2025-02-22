import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/widget/KeyBoardMouseEvent.dart';
import '../../../viewmodel/main/information/setting_app_view_model.dart';
import '../../../widget/button.dart';
import '../../../widget/divider.dart';

// 정보 탭 관리 화면
class SettingAppScreen extends StatelessWidget {
  final SettingAppViewModel _viewModel = Get.put(SettingAppViewModel());
  SettingAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.screenController.updateScreenSize(context);
    });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return keyBoardMouseEvent(
      child: Scaffold(
        appBar: AppBar(
          // leading: SimpleBackButtonWidget(
          //   function: _viewModel.goInformation,
          // ),
          title: Text(
            '관리',
            style: TextStyle(fontSize: screenSize.getHeightPerSize(2.5)),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //AudioSettingWidget(viewModel: _viewModel),
              SizedBox(height: screenSize.getHeightPerSize(1)),
              _settingTitle(screenSize, '정보 설정'),
              informationButton('데이터 새로고침', _viewModel.tryGetData, screenSize),
              settingDivider(screenSize),
              informationButton('내 이름 변경', _viewModel.nameChangeDialog, screenSize),
              settingDivider(screenSize),
              informationButton('대표 팬덤 변경', _viewModel.changeFandomDialog, screenSize),
              SizedBox(height: screenSize.getHeightPerSize(1)),
              _settingTitle(screenSize, '계정 설정'),
              informationButton('파산 신청', _viewModel.tryRestart, screenSize),
              settingDivider(screenSize),
              informationButton('회원탈퇴', _viewModel.goDeleteAccount, screenSize),
              settingDivider(screenSize),
              informationButton('비밀번호 변경', _viewModel.sendPasswordResetEmail, screenSize),
              settingDivider(screenSize),
              informationButton('로그아웃', _viewModel.logoutDialog, screenSize),
              SizedBox(height: screenSize.getHeightPerSize(1)),
              Visibility(
                visible: GetPlatform.isDesktop,
                child: Column(
                  children: [
                    _settingTitle(screenSize, '어플 설정'),
                    informationButton('해상도 설정', _viewModel.windowsSizeDialog, screenSize),
                  ],
                ),
              ),
              SizedBox(height: screenSize.getHeightPerSize(1)),
              _settingTitle(screenSize, '앱 정보'),
              informationButton('앱 버전 정보', _viewModel.showAppVersion, screenSize),
              settingDivider(screenSize),
              informationButton('오픈소스 라이선스', () => _viewModel.showLicenses(context), screenSize),
              SizedBox(height: screenSize.getHeightPerSize(1)),
            ],
          ),
        ),
      ),
    );
  }

  // 정보 탭 대분류 제목 위젯
  Widget _settingTitle(ScreenSize screenSize, String title) {
    return Padding(
      padding: EdgeInsets.only(left: screenSize.getWidthPerSize(2)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: screenSize.getHeightPerSize(1.8),
          ),
        ),
      ),
    );
  }
}
