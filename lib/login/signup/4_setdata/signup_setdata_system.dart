import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/simple_widget.dart';
import '../../../data/public_data.dart';
import '../../../utils/get_env.dart';
import '../../../utils/data_storage.dart';
import '../../login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:profanity_filter/profanity_filter.dart';

class SignUpSetDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingUpSetDataControll());
  }
}

class SingUpSetDataControll extends GetxController {
  final TextEditingController controllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final filter = ProfanityFilter();
  late bool overlapName;

  RxInt listIndex = 0.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    controllerName.dispose();
    super.onClose();
  }

  void cancelSignUp() {
    Get.offAll(() => LoginScreen());
  }

  Future<void> trySetUserData() async {
    String? uid = await getUID();
    EasyLoading.show(status: '사용자 데이터 등록중');
    final userData = await http.put(
      Uri.parse('$httpURL/users/set'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': uid.toString(),
        'name': controllerName.text,
        'choicechannel': fanNameList[listIndex.value],
      }),
    );

    if (userData.statusCode == 201) {
      await deleteIDPW();
      await clearTokens();
      EasyLoading.dismiss();
      showSimpleSnackbar('회원가입 완료', '회원가입이 완료되었습니다', SnackPosition.TOP, Colors.black);
      cancelSignUp();
    } else {
      EasyLoading.dismiss();
      print(jsonDecode(userData.body));
      showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
    }
  }
}
