import 'dart:math';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../data/my_data.dart';
import '../../utils/data_storage.dart';
import '../../utils/timer.dart';
import 'mysetting/my_information_setting_screen.dart';

class MoneyChartClass {
  String name;
  int money;

  MoneyChartClass(this.name, this.money);
}

class InformationController extends GetxController {
  final MyDataController _myDataController = Get.find<MyDataController>();
  RxInt minValue = 0.obs;
  RxDouble rate = 0.0.obs;
  RxList<MoneyChartClass> moneyChartList = <MoneyChartClass>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setMinValue();
    profitRate();
    setMoneyChartData();
  }

  void setMoneyChartData() {
    moneyChartList.clear();
    moneyChartList.add(MoneyChartClass('현금 자산', _myDataController.myMoney.value));
    moneyChartList.add(MoneyChartClass('주식 자산', _myDataController.myStockMoney.value));
  }

  void setMinValue() {
    int minV = _myDataController.totalMoneyHistoryList.reduce(min);

    if (minV > 10000) {
      minValue.value = (minV ~/ 10000) * 10000;
    } else {
      minValue.value = 0;
    }
  }

  void profitRate() {
    if (_myDataController.totalMoneyHistoryList.length > 1) {
      rate.value = ((_myDataController.myTotalMoney.value -
                  _myDataController
                      .totalMoneyHistoryList[_myDataController.totalMoneyHistoryList.length - 2]) /
              _myDataController
                  .totalMoneyHistoryList[_myDataController.totalMoneyHistoryList.length - 2]) *
          100;
    } else {
      rate.value = 0.0;
    }
  }

  void goSetting() {
    Get.to(() => const MyInformationSettingScreen());
  }

  void goLogin() {
    Get.offAllNamed('/login');
  }

  void logOut() async {
    EasyLoading.show();
    await clearTokens();
    Get.delete<TimerController>();
    EasyLoading.dismiss();
    goLogin();
  }
}
