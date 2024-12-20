import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/setting/setting_system.dart';
import 'package:stockpj/main/information/setting/setting_widget.dart';

// 정보 탭 관리 화면
class SettingScreen extends StatelessWidget {
  final SettingController _settingController = Get.put(SettingController());
  SettingScreen({super.key});

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
          SettingAudioWidget(),
          SettingButtonWidget(
            title: '데이터 새로고침',
            function: _settingController.tryGetData,
          ),
          settingDivider(),
          SettingButtonWidget(
            title: '파산 신청',
            function: _settingController.restart,
          ),
          settingDivider(),
          SettingButtonWidget(
            title: '회원탈퇴',
            function: _settingController.goWithdrawal,
          ),
        ],
      ),
    );
  }
}
