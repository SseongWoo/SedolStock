import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/setting/setting_widget.dart';
import 'package:stockpj/utils/simple_widget.dart';

import '../../../data/start_data.dart';
import '../../../utils/timer.dart';
import '../withdrawal/withdrawal_screen.dart';

class SettingController extends GetxController {
  final TimerController _timerController = Get.find<TimerController>();
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
    if (_timerController.checkDataTime.value) {
      showSimpleDialog(Get.back, '데이터 갱신 실패', '현재 서버에서 데이터를 갱신 중입니다. 갱신 완료 후 다시 이용해 주세요.');
    } else {
      EasyLoading.show(status: '데이터 불러오는중');
      await startGetData();
      EasyLoading.dismiss();
      showSimpleSnackbar(
          '데이터 수동 갱신 성공', '데이터 갱신이 완료되었습니다. 최신 정보로 업데이트되었습니다!', SnackPosition.TOP, Colors.black);
    }
  }
}
