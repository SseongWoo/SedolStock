import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/http_request.dart';
import '../../../utils/data_storage.dart';
import '../../../utils/simple_widget.dart';
import '../../login/login_screen.dart';
import '../4_setdata/signup_setdata_screen.dart';
import '../4_setdata/signup_setdata_system.dart';

class SignUpCheckEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingUpCheckEmailControll());
  }
}

class SingUpCheckEmailControll extends GetxController {
  late String email;

  Future<void> deleteUserData(String uid) async {
    await http.post(
      Uri.parse('$httpURL/deleteUser/$uid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': uid,
      }),
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    email = Get.arguments;
  }

  void cancelSignUp() async {
    String? uid = await getUID();
    await deleteUserData(uid.toString());
    Get.offAll(() => LoginScreen());
  }

  void goSignUpSetProfile() {
    Get.offAll(() => const SignupSetprofileScreen(), binding: SignUpSetDataBinding());
  }

  Future<void> sendEmail() async {
    EasyLoading.show();
    final Map<String, String> userID = await getIDPW();
    final String id = userID['id']!;
    final String pw = userID['pw']!;

    final sendEmail = await http.post(
      Uri.parse('$httpURL/users/sendemail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': id,
        'password': pw,
      }),
    );

    if (sendEmail.statusCode == 200) {
      showSimpleSnackbar('전송 완료', '이메일 재전송에 성공하였습니다.', SnackPosition.TOP, Colors.black);
    } else {
      showSimpleSnackbar('전송 실패', '이메일 재전송에 실패하였습니다. 다시 시도해 주세요', SnackPosition.TOP, Colors.red);
    }
    EasyLoading.dismiss();
  }

  Future<void> checkEmail() async {
    Map<String, dynamic>? jsonData;
    bool emailCheck;
    EasyLoading.show();
    final String? uid = await getUID();

    final checkEmail = await http.post(Uri.parse('$httpURL/users/checkemail'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uid': uid.toString(),
        }));

    if (checkEmail.statusCode == 200) {
      jsonData = jsonDecode(checkEmail.body);
      emailCheck = jsonData!['emailVerified'];

      if (emailCheck) {
        goSignUpSetProfile();
      } else {
        showSimpleDialog(Get.back, '인증 확인', '이메일 인증이 완료되지 않았습니다. 이메일을 확인하고 인증 링크를 클릭하세요.');
      }
    } else {
      showSimpleSnackbar('전송 실패', '이메일 재전송에 실패하였습니다. 다시 시도해 주세요', SnackPosition.TOP, Colors.red);
    }
    EasyLoading.dismiss();
  }
}
