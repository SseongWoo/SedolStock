import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../data/my_data.dart';
import '../../../data/public_data.dart';
import '../../../model/main/information_model.dart';
import '../../../utils/screen_size.dart';
import '../../../widget/simple_widget.dart';

class DeleteAccountViewModel extends GetxController {
  InformationModel informationModel = InformationModel();
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  RxBool checkBox = false.obs;
  // 회원탈퇴 취소
  void cencel() {
    Get.back();
  }

  // 회원탈퇴 작업 시작
  Future<void> startDeleteAccount() async {
    try {
      EasyLoading.show();
      if (checkBox.value) {
        bool checkDelete = await informationModel.deleteUserData(
            _myDataController.myUid.value, _myDataController.myName.value);
        if (checkDelete) {
          showSimpleSnackbar('회원탈퇴 성공', '회원탈퇴에 성공했습니다.', SnackPosition.TOP, Colors.black);
          _publicDataController.logOut();
        } else {
          showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
        }
      }
    } catch (e) {
      showSimpleDialog(Get.back, '오류', '알수없는 오류가 발생했습니다.\n다시 시도해 주세요');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
