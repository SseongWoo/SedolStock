import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/setting/setting_widget.dart';

import '../../../data/start_data.dart';
import '../withdrawal/withdrawal_screen.dart';

class SettingController extends GetxController {
  void restart() {
    Get.dialog(ReStartDialog());
  }

  void goWithdrawal() {
    Get.to(() => WithdrawalScreen());
  }

  void tryGetData() async {
    EasyLoading.show(status: '데이터 불러오는중');
    await startGetData();
    EasyLoading.dismiss();
  }
}
