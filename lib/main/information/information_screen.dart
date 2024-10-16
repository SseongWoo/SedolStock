import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/information_system.dart';
import 'package:stockpj/utils/color.dart';
import '../../utils/get_data.dart';
import '../../utils/screen_size.dart';
import 'information_widget.dart';

class InformationScreen extends StatelessWidget {
  final InformationController _informationController = Get.put(InformationController());
  final ScreenController _screenController = Get.put(ScreenController());
  InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Container(
      color: colorAkaneLizeLight,
      child: SingleChildScrollView(
        child: Column(
          children: [
            InformationMyWidget(),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(20),
              color: Colors.white,
              child: const Text('내 수익률 그래프'),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            InformationPropertyWidget(),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(1),
            ),
            settingTitle('정보 설정'),
            InformationButtonWidget(
              title: '내 정보 수정',
              function: _informationController.goSetting,
            ),
            settingDivider(),
            InformationButtonWidget(
              title: '파산',
              function: _informationController.goSetting,
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(1),
            ),
            settingTitle('계정 설정'),
            InformationButtonWidget(
              title: '로그아웃',
              function: _informationController.logOut,
            ),
            settingDivider(),
            InformationButtonWidget(
              title: '비밀번호 변경',
              function: _informationController.goSetting,
            ),
            settingDivider(),
            InformationButtonWidget(
              title: '이메일 인증',
              function: _informationController.goSetting,
            ),
            settingDivider(),
            InformationButtonWidget(
              title: '회원탈퇴',
              function: getUserData,
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(1),
            ),
            settingTitle('어플 설정'),
            InformationButtonWidget(
              title: '설정',
              function: _informationController.goSetting,
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(1),
            ),
          ],
        ),
      ),
    );
  }
}
