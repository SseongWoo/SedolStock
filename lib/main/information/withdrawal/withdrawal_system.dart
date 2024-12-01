import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../data/my_data.dart';
import '../../../data/public_data.dart';
import '../../../main.dart';
import '../../../utils/get_env.dart';
import '../../../utils/simple_widget.dart';

class WithdrawalController extends GetxController {
  final MyDataController _myDataController = Get.find<MyDataController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  RxBool checkBox = false.obs;

  // 회원탈퇴 취소
  void cencel() {
    Get.back();
  }

  // 회원탈퇴 작업 시작
  void startDelete() async {
    if (checkBox.value) {
      await deleteUserData();
    }
  }

  // 회원탈퇴 작업
  Future<void> deleteUserData() async {
    try {
      EasyLoading.show(status: '회원탈퇴 중');

      final response = await http.delete(
        Uri.parse('$httpURL/deleteUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            {'uid': _myDataController.myUid.value, 'name': _myDataController.myName.value}),
      );
      if (response.statusCode == 200) {
        showSimpleSnackbar('회원탈퇴 성공', '회원탈퇴에 성공했습니다.', SnackPosition.TOP, Colors.black);
        _publicDataController.logOut();
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
      }
    } catch (e) {
      EasyLoading.dismiss();
      showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
      logger.e('deleteUserData error : $e');
    }
  }
}
