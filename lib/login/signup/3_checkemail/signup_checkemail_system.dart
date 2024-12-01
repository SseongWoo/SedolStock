import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/my_data.dart';
import '../../../main.dart';
import '../../../utils/get_env.dart';
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
  final MyDataController myDataController = Get.find<MyDataController>();
  late String email;
  late String pw;

  // 유저 데이터 삭제 함수
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    email = arguments['id'];
    pw = arguments['pw'];
  }

  // 회원가입을 취소하고 로그인화면으로 되돌아가는 함수
  void cancelSignUp() async {
    String? uid = await getUID();
    await deleteUserData(uid.toString());
    Get.offAll(() => LoginScreen());
  }

  // 회원가입 4단계로 이동하는 함수
  void goSignUpSetProfile() {
    Get.offAll(() => const SignupSetprofileScreen(), binding: SignUpSetDataBinding());
  }

  // 이메일 계정에 인증 이메일을 전송하는 함수
  Future<void> sendEmail() async {
    EasyLoading.show();
    try {
      final sendEmail = await http.post(
        Uri.parse('$httpURL/users/sendemail'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': pw,
        }),
      );
      EasyLoading.dismiss();
      if (sendEmail.statusCode == 200) {
        showSimpleSnackbar('전송 완료', '이메일 재전송에 성공하였습니다.', SnackPosition.TOP, Colors.black);
      } else {
        showSimpleSnackbar('전송 실패', '이메일 재전송에 실패하였습니다. 다시 시도해 주세요', SnackPosition.TOP, Colors.red);
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e('sendEmail error : $e');
    }
  }

  // 이메일 인증을 완료했는지 확인하는 함수
  Future<void> checkEmail() async {
    Map<String, dynamic>? jsonData;
    bool emailCheck;
    EasyLoading.show();

    try {
      final String? uid =
          myDataController.myUid.value != '' ? myDataController.myUid.value : await getUID();

      if (uid == null) {
        throw Exception('uid is impty.');
      }

      final checkEmail = await http.post(
        Uri.parse('$httpURL/users/checkemail'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uid': uid.toString(),
        }),
      );

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
    } catch (e) {
      EasyLoading.dismiss();
      logger.e('checkEmail error : $e');
    }
  }
}
