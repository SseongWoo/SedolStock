import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/model/sign/find_account_model.dart';
import '../../config/route.dart';
import '../../utils/check_list.dart';
import '../../utils/screen_size.dart';
import '../../widget/simple_widget.dart';

class FindAccountViewModel extends GetxController {
  final ScreenController screenController = Get.find<ScreenController>();
  final FindAccountModel findAccountModel = FindAccountModel();
  final formKey = GlobalKey<FormState>();
  final TextEditingController controllerName = TextEditingController();

  // 로그인 화면으로 이동
  void goSignin() {
    Get.offAllNamed(AppRoute.signin);
  }

  // 이메일 유효성 검증
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해 주세요';
    }
    if (!isValidEmail(value)) {
      return '유효한 이메일 형식이 아닙니다';
    }
    return null;
  }

  // 비밀번호 재설정 이메일 전송
  void onPressed() async {
    if (!formKey.currentState!.validate()) {
      return; // 유효성 검사 실패 시 반환
    }

    EasyLoading.show(status: '이메일 전송 중...');
    final sendEmail = await findAccountModel.sendFindEmail(controllerName.text);

    if (sendEmail) {
      showSimpleSnackbar(
          '이메일 전송 성공', '비밀번호 재설정 링크가 이메일로 전송되었습니다\n이메일을 확인해주세요', SnackPosition.TOP, Colors.black);
      goSignin();
    } else {
      showSimpleDialog(Get.back, '오류', '이메일 전송에 실패하였습니다. 다시 시도해 주세요');
    }
    EasyLoading.dismiss();
  }
}
