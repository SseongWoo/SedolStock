import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/simple_widget.dart';
import '../../../data/my_data.dart';
import '../../../data/public_data.dart';
import '../../../main.dart';
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
  final MyDataController _myDataController = Get.find<MyDataController>();
  final TextEditingController controllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final filter = ProfanityFilter(); // 비속어 감지 필터
  late bool overlapName; // 설정할 이름이 이미 존재하는지 확인하는 변수
  RxInt listIndex = 0.obs;
  RxString? uid = ''.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    if (_myDataController.myUid.value != '') {
      uid = _myDataController.myUid;
    } else {
      uid?.value = (await getUID())!;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    controllerName.dispose();
    super.onClose();
  }

// 사용자 데이터 삭제하는 함수
  Future<void> deleteUserData(String uid) async {
    try {
      await http.post(
        Uri.parse('$httpURL/deleteUser/$uid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uid': uid,
        }),
      );
    } catch (e) {
      logger.e('deleteUserData error : $e');
    }
  }

  // 회원가입을 취소하고 로그인 화면으로 넘어가는 함수
  void cancelSignUp() async {
    EasyLoading.show();
    await deleteUserData(uid!.value);
    EasyLoading.dismiss();
    Get.offAll(() => LoginScreen());
  }

  Future<void> trySetUserData() async {
    EasyLoading.show(status: '사용자 데이터 등록중');
    try {
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
        await deleteID();
        await clearTokens();
        EasyLoading.dismiss();
        showSimpleSnackbar('회원가입 완료', '회원가입이 완료되었습니다', SnackPosition.TOP, Colors.black);
        cancelSignUp();
      } else {
        EasyLoading.dismiss();
        showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
      }
    } catch (e) {
      logger.e('trySetUserData error : $e');
      EasyLoading.dismiss();
      showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
    }
  }
}
