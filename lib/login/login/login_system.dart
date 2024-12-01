import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:stockpj/data/start_data.dart';
import 'package:stockpj/main/main_screen.dart';
import 'package:stockpj/login/find_account/find_account_screen.dart';
import 'package:stockpj/utils/get_env.dart';
import '../../data/my_data.dart';
import '../../main.dart';
import '../../utils/data_storage.dart';
import '../../utils/simple_widget.dart';
import '../find_account/find_account_system.dart';
import '../signup/1_choice/signup_choice_screen.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}

class LoginController extends GetxController {
  final MyDataController _myDataController = Get.find<MyDataController>();
  final TextEditingController controllerID = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    controllerID.dispose();
    controllerPassword.dispose();
  }

  // 회원가입 화면으로 이동
  void goSignUp() {
    Get.to(() => SignUpChoiceScreen());
  }

  // 계정 찾기 화면으로 이동
  void goFindAccount() {
    Get.to(() => FindAccountScreen(), binding: FindAccountBinding());
  }

  // 로그인을 완료하고 메인 홈 화면으로 이동
  void goHome() {
    Get.offAll(() => MainScreen());
  }

  // 로그인 버튼을 눌렀을때 실행되는 함수로 올바른 계정일경우 홈 화면으로 이동 아닐경우 오류 메세지 출력
  Future<void> tryLogin(String email, String password) async {
    Map<String, dynamic>? jsonData;

    try {
      final String uid;
      final String refreshToken;
      final String accessToken;

      EasyLoading.show(status: '로그인중');
      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>~`+=_-]').hasMatch(controllerID.text)) {
        email = '$email@geuset.login';
      }

      final response = await http.post(
        Uri.parse('$httpURL/signin'),
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
        _myDataController.myUid.value = uid;
        await setTokens(accessToken, refreshToken, uid);
        bool checkMyData = await getUserData();
        bool checkMyWalletData = await getWalletData();

        if (checkMyData && checkMyWalletData) {
          await startGetData();
          goHome();
        } else {
          throw Exception('MyData is missing.');
        }
      } else {
        throw Exception('LoginData is missing.');
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      logger.e('tryLogin error : $e');
      showSimpleDialog(Get.back, '로그인 실패', '입력하신 정보가 일치하지 않습니다.\n다시 시도해 주세요.');
    }
  }
}
