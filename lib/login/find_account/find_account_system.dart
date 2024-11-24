import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stockpj/utils/simple_widget.dart';
import '../../utils/get_env.dart';
import '../login/login_screen.dart';

class FindAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindAccountController());
  }
}

class FindAccountController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController controllerName = TextEditingController();

  @override
  void onClose() {
    // TODO: implement onClose
    controllerName.dispose();
    super.onClose();
  }

  void goLogin() {
    Get.offAll(() => LoginScreen());
  }

  // 비밀번호 찾기 이메일을 보내는 함수
  Future<void> sendFindEmail() async {
    EasyLoading.show(status: '확인중');
    final response = await http.post(
      Uri.parse('$httpURL/users/reset'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': controllerName.text}),
    );

    if (response.statusCode == 200) {
      showSimpleSnackbar(
          '이메일 전송 성공', '비밀번호 재설정 링크가 이메일로 전송되었습니다\n이메일을 확인해주세요', SnackPosition.TOP, Colors.black);
      goLogin();
    } else {
      showSimpleDialog(Get.back, '오류', '입력하신 이메일이 존재 않습니다.\n다시 시도해 주세요.');
    }
    EasyLoading.dismiss();
  }
}
