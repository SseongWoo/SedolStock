import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/information_system.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/data_storage.dart';
import '../../data/my_data.dart';
import '../../data/public_data.dart';
import '../../data/youtube_data.dart';
import '../../utils/screen_size.dart';
import 'information_widget.dart';

class InformationScreen extends StatelessWidget {
  final InformationController _informationController = Get.put(InformationController());
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
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
            height: _screenController.screenSize.value.getHeightPerSize(30),
            color: Colors.white,
            child: const TradeDatailChartWidget(),
          ),
          Container(
            height: _screenController.screenSize.value.getHeightPerSize(30),
            color: Colors.white,
            child: StockPieChartWidget(),
          ),
          Container(
            height: _screenController.screenSize.value.getHeightPerSize(30),
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
            title: '선택 채널 변경',
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
          InformationButtonWidget(
            title: '테스트 버튼',
            function: _informationController.test,
          ),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(1),
          ),
        ],
      ),
    );
  }
}
