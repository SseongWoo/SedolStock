import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../utils/secure_storage.dart';
import '../../utils/timer.dart';
import 'mysetting/my_information_setting_screen.dart';

class InformationController extends GetxController {
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
