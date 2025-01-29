import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/constants/route_constants.dart';
import 'package:stockpj/utils/color.dart';
import '../../../data/my_data.dart';
import '../../../model/main/information_model.dart';
import '../../../utils/change_fandom.dart';
import '../../../utils/screen_size.dart';

// 정보 탭 뷰모델
class InformationViewModel extends GetxController {
  final InformationModel informationModel = InformationModel();
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  RxList<FlSpot> chartSpots = <FlSpot>[].obs;
  RxBool notBankruptcy = true.obs; // 파산 확인 변수

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _checkNotBankruptcy();
    _setMoneyHistoryChartSpots();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(
      myDataController.myTotalMoney,
      (callback) {
        _checkNotBankruptcy();
        _setMoneyHistoryChartSpots();
      },
    );
  }

  // 관리 화면으로 이동하는 함수
  void goSetting() {
    //Get.toNamed(AppRoute.settingApp);
    Get.offAllNamed(
      AppRoute.settingApp,
    );
  }

  // 사용자 자산 변동 그래프 데이터 설정
  void _setMoneyHistoryChartSpots() {
    final list = myDataController.totalMoneyHistoryList
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.money.toDouble(),
            ))
        .toList();

    // 리스트의 마지막 10개의 값만 가져오기
    final last10 = list.length > 10 ? list.sublist(list.length - 10) : list;

    // x 값을 0부터 다시 설정
    chartSpots.value =
        last10.asMap().entries.map((entry) => FlSpot(entry.key.toDouble(), entry.value.y)).toList();
  }

  double chartMaxValue() {
    final maxValue = chartSpots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) + 500000;
    return ((maxValue / 500000).ceil() * 500000).toDouble();
  }

  // 사용자의 자산 변동률을 계산하는 함수
  RateConfigClass profitRate() {
    double myRate;
    Color myRateColor;
    if (myDataController.totalMoneyHistoryList.length > 1) {
      myRate = (((myDataController.myTotalMoney.value -
                  myDataController
                      .totalMoneyHistoryList[myDataController.totalMoneyHistoryList.length - 2]
                      .money) /
              myDataController
                  .totalMoneyHistoryList[myDataController.totalMoneyHistoryList.length - 2].money) *
          100);
      myRate = double.parse(
        myRate.toStringAsFixed(2),
      );
      if (myRate > -0.01 && myRate < 0.01) {
        myRate = 0.0;
      }
    } else {
      myRate = 0.0;
    }
    myRateColor = profitAndLossColor(myRate);

    return RateConfigClass(myRate, myRateColor);
  }

  // 팬덤 변경 다이어로그 호출
  void changeFandomDialog() {
    Get.dialog(
      FandomChangeDialog(
        screenSize: screenController.screenSize.value,
        myDataController: myDataController,
      ),
    );
  }

  // 파산 확인
  void _checkNotBankruptcy() {
    notBankruptcy.value = myDataController.myTotalMoney.value > 0 ? true : false;
  }
}
