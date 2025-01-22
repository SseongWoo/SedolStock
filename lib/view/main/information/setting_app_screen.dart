import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/view/main/information/setting_widget.dart';
import '../../../viewmodel/main/information/setting_app_view_model.dart';
import '../../../widget/button.dart';
import '../../../widget/divider.dart';

// 정보 탭 관리 화면
class SettingAppScreen extends StatelessWidget {
  final SettingAppViewModel _viewModel = Get.put(SettingAppViewModel());
  SettingAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('관리'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          AudioSettingWidget(
            viewModel: _viewModel,
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(1),
          ),
          _settingTitle(screenSize, '정보 설정'),
          informationButton('데이터 새로고침', _viewModel.tryGetData, screenSize),
          settingDivider(screenSize),
          informationButton('내 이름 변경', _viewModel.nameChangeDialog, screenSize),
          settingDivider(
            screenSize,
          ),
          informationButton('대표 팬덤 변경', _viewModel.changeFandomDialog, screenSize),
          SizedBox(
            height: screenSize.getHeightPerSize(1),
          ),
          _settingTitle(screenSize, '계정 설정'),
          informationButton('파산 신청', _viewModel.restartDialog, screenSize),
          settingDivider(screenSize),
          informationButton('회원탈퇴', _viewModel.goDeleteAccount, screenSize),
          settingDivider(screenSize),
          informationButton('비밀번호 변경', _viewModel.sendPasswordResetEmail, screenSize),
          settingDivider(
            screenSize,
          ),
          informationButton('로그아웃', _viewModel.logoutDialog, screenSize),
          SizedBox(
            height: screenSize.getHeightPerSize(1),
          ),
        ],
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
