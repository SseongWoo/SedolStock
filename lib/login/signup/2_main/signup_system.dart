import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stockpj/utils/simple_widget.dart';
import '../../../utils/date_time.dart';
import '../../../utils/http_request.dart';
import '../../../utils/secure_storage.dart';
import '../../login/login_screen.dart';
import '../3_checkemail/signup_checkemail_screen.dart';
import '../3_checkemail/signup_checkemail_system.dart';
import '../4_setdata/signup_setdata_screen.dart';
import '../4_setdata/signup_setdata_system.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingUpEmailControll());
  }
}

class SingUpEmailControll extends GetxController {
  final TextEditingController controllerID = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerPasswordCheck = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controllerID.dispose();
    controllerPassword.dispose();
    controllerPasswordCheck.dispose();
  }

  void goSignUpCheckEmail() {
    Get.offAll(() => SignupCheckemailScreen(),
        binding: SignUpCheckEmailBinding(), arguments: controllerID.text);
  }

  void backSignUp() {
    Get.offAll(() => LoginScreen());
  }

  void goSignUpSetProfile() {
    Get.offAll(() => const SignupSetprofileScreen(), binding: SignUpSetDataBinding());
  }

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

  // 회원가입 시작 함수
  Future<void> trySignUp() async {
    final bool checkEmail;
    final String email;
    final String password;
    final String uid;
    final String refreshToken;
    final String accessToken;
    Map<String, dynamic>? jsonData;

    if (RegExp(r'[!@#$%^&*(),.?":{}|<>~`+=_-]').hasMatch(controllerID.text)) {
      email = controllerID.text;
      checkEmail = true;
    } else {
      email = '${controllerID.text}@geuset.login';
      checkEmail = false;
    }
    password = controllerPassword.text;
    EasyLoading.show();
    final response = await http.post(
      Uri.parse('$httpURL/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      jsonData = jsonDecode(response.body);
      uid = jsonData!['user']['uid'];
      refreshToken = jsonData['user']['stsTokenManager']['refreshToken'];
      accessToken = jsonData['user']['stsTokenManager']['accessToken'];
      setTokens(accessToken, refreshToken, uid);

      final signUpUserData = await http.post(
        Uri.parse('$httpURL/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uid': uid,
          'id': controllerID.text,
          'firstlogintime': formatDateTime(DateTime.now())
        }),
      );

      if (signUpUserData.statusCode == 201) {
        if (checkEmail) {
          await setIDPW(email, password);

          final sendEmail = await http.post(
            Uri.parse('$httpURL/users/sendemail'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': email,
              'password': password,
            }),
          );
          if (sendEmail.statusCode == 200) {
            goSignUpCheckEmail();
          } else {
            deleteUserData(uid);
            showSimpleDialog(Get.back, '오류', '이메일 전송에 실패했습니다.\n다시 시도해 주세요');
          }
        } else {
          goSignUpSetProfile();
        }
      } else {
        controllerID.clear();
        controllerPassword.clear();
        controllerPasswordCheck.clear();
        deleteUserData(uid);
        showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
      }
    } else {
      controllerID.clear();
      controllerPassword.clear();
      controllerPasswordCheck.clear();
      showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
    }
    EasyLoading.dismiss();
  }
}
