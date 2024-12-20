import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/information_system.dart';
import '../../utils/screen_size.dart';
import 'information_widget.dart';

// 정보 화면
class InformationScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final InformationController _informationController = Get.find<InformationController>();
  InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InformationMyWidget(),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(2),
          ),
          Container(
            height: _screenController.screenSize.value.getHeightPerSize(35),
            color: Colors.white,
            child: ChartLine(),
          ),
          Container(
            height: _screenController.screenSize.value.getHeightPerSize(38),
            color: Colors.white,
            child: StockPieChartWidget(),
          ),
          Container(
            height: _screenController.screenSize.value.getHeightPerSize(35),
            color: Colors.white,
            child: MoneyPieChartWidget(),
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
            title: '내 이름 변경',
            function: _informationController.nameChange,
          ),
          settingDivider(),
          InformationButtonWidget(
            title: '대표 팬덤 변경',
            function: _informationController.channelChange,
          ),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(1),
          ),
          settingTitle('계정 설정'),
          InformationButtonWidget(
            title: '비밀번호 변경',
            function: _informationController.startPWChange,
          ),
          settingDivider(),
          InformationButtonWidget(
            title: '로그아웃',
            function: _informationController.startLogOut,
          ),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(1),
          ),
          settingTitle('데이터 및 계정 관리'),
          InformationButtonWidget(
            title: '관리',
            function: _informationController.goSetting,
          ),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(1),
          ),
        ],
      ),
    );
  }
}
