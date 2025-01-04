import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('관리'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          AudioSettingWidget(
            viewModel: _viewModel,
          ),
          informationButton(
            '데이터 새로고침',
            _viewModel.tryGetData,
          ),
          settingDivider(_viewModel.screenController.screenSize.value),
          informationButton(
            '파산 신청',
            _viewModel.restartDialog,
          ),
          settingDivider(_viewModel.screenController.screenSize.value),
          informationButton(
            '회원탈퇴',
            _viewModel.goDeleteAccount,
          ),
        ],
      ),
    );
  }
}
