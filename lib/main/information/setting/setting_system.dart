import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/setting/setting_widget.dart';

import '../../../data/start_data.dart';
import '../withdrawal/withdrawal_screen.dart';

class SettingController extends GetxController {
  // 파산 신청
  void restart() {
    Get.dialog(ReStartDialog());
  }

  // 회원 탈퇴
  void goWithdrawal() {
    Get.to(() => WithdrawalScreen());
  }

  // 데이터 수동 새로 고침
  void tryGetData() async {
    EasyLoading.show(status: '데이터 불러오는중');
    await startGetData();
    EasyLoading.dismiss();
  }
}
