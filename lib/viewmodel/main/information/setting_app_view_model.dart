import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import '../../../constants/route_constants.dart';
import '../../../data/my_data.dart';
import '../../../data/start_data.dart';
import '../../../model/main/information_model.dart';
import '../../../utils/audio.dart';
import '../../../utils/screen_size.dart';
import '../../../widget/simple_widget.dart';
import '../../../utils/timer.dart';
import '../../../view/main/information/setting_widget.dart';

class SettingAppViewModel extends GetxController {
  final InformationModel _informationModel = InformationModel();
  final TimerController _timerController = Get.find<TimerController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  final ScreenController screenController = Get.find<ScreenController>();
  final AudioController audioController = Get.find<AudioController>();
  final MyDataController myDataController = Get.find<MyDataController>();

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

  // 파산 신청
  void restartDialog() {
    Get.dialog(
      RestartDialog(
        screenSize: screenController.screenSize.value,
        onPressed: restart,
      ),
    );
  }

  // 계정 정보 초기화 함수(파산 신청)
  void restart() async {
    EasyLoading.show(status: '초기화 중');

    String uid = myDataController.myUid.value;

    bool restart = await _informationModel.restartUserData(uid);

    if (restart) {
      showSimpleSnackbar('초기화 성공', '초기화에 성공했습니다. 다시 로그인해주세요.', SnackPosition.TOP, Colors.black);
      _publicDataController.logOut();
    } else {
      showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
    }
    EasyLoading.dismiss();
  }

  // 회원 탈퇴
  void goDeleteAccount() {
    Get.toNamed(AppRoute.deleteAccount);
  }
}
