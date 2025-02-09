import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/timer.dart';
import '../constants/route_constants.dart';
import '../data/my_data.dart';
import '../service/storage_service.dart';

// 로그아웃 기능 함수
void logOut() async {
  final MyDataController myDataController = Get.find<MyDataController>();

  EasyLoading.show();
  myDataController.ownStock.clear();
  await clearTokens();
  Get.delete<TimerController>();
  EasyLoading.dismiss();
  Get.offAllNamed(AppRoute.signin);
}
