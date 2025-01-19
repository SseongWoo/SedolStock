import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/main.dart';
import '../../constants/route_constants.dart';
import '../../data/my_data.dart';
import '../../data/start_data.dart';
import '../../model/sign/signin_model.dart';
import '../../service/storage_service.dart';
import '../../utils/screen_size.dart';
import '../../widget/simple_widget.dart';

// 로그인 뷰 모델
class SigninViewModel extends GetxController {
  final SigninModel signinModel = SigninModel();
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  // 홈 화면 이동
  void goHome() {
    Get.offAllNamed(AppRoute.home);
  }

  // 회원가입 화면 이동
  void goSignup() {
    Get.toNamed(AppRoute.signupChoice);
  }

  // 비밀번호 찾기 화면 이동
  void goFindPW() {
    Get.toNamed(AppRoute.findPW);
  }

  // 이메일 인증 화면 이동
  void goCheckEmail() {
    Get.offAllNamed(AppRoute.signupCheckEmail,
        arguments: {'id': controllerEmail.text, 'pw': controllerPassword.text});
  }

  // 이메일 처리
  String _processEmail(String email) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>~`+=_-]').hasMatch(email) ? email : '$email@guest.login';
  }

  // 입력 유효성 검사
  bool _isValidInput(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }

  // 사용자 데이터 초기화
  Future<void> _initializeUserData(String uid, String token) async {
    _myDataController.myUid.value = uid;
    await setTokens(token, uid);
    bool checkMyData = await _myDataController.getUserData();
    bool checkMyWalletData = await _myDataController.getWalletData();

    if (!checkMyData || !checkMyWalletData) {
      throw Exception('MyData is missing.');
    }

    await startGetData();
  }

  // 로그인 시도
  Future<void> signin() async {
    try {
      EasyLoading.show();
      if (!_isValidInput(controllerEmail.text, controllerPassword.text)) {
        showSimpleSnackbar('입력 오류', '이메일과 비밀번호를 입력해주세요.', SnackPosition.TOP, Colors.red);
        return;
      }
      String email = _processEmail(controllerEmail.text);
      String password = controllerPassword.text;

      final signinData = await signinModel.signin(email, password);
      if (!signinData.checkemail) {
        showSimpleDialog(goCheckEmail, '회원가입 미완료', '회원가입이 중단된 상태입니다. 아래 버튼을 눌러 계속 진행해주세요!');
        return;
      }
      await _initializeUserData(signinData.uid, signinData.token);
      goHome();
    } catch (e) {
      logger.e(e);
      showSimpleSnackbar('로그인 오류', '오류가 발생했습니다. 다시 시도해주세요.', SnackPosition.TOP, Colors.red);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
