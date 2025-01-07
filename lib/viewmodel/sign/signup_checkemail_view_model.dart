import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/constants/route_constants.dart';
import '../../model/sign/signup_model.dart';
import '../../service/storage_service.dart';
import '../../utils/screen_size.dart';
import '../../widget/simple_widget.dart';

// 회원가입 3단계 뷰모델
class SignupCheckemailViewModel extends GetxController {
  final SignupModel signupModel = SignupModel();
  final ScreenController screenController = Get.find<ScreenController>();
  String id = '';
  String pw = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final arguments = (Get.arguments as Map?) ?? {};
    id = arguments['id']?.toString() ?? '';
    pw = arguments['pw']?.toString() ?? '';
  }

  // 다음 화면으로 이동
  void goSignUp() {
    Get.offAllNamed(
      AppRoute.signin,
    );
  }

  // 회원가입을 취소하고 로그인화면으로 되돌아가는 함수
  void cancelSignUp() async {
    String? uid = await getUID();
    signupModel.setUid(uid!);
    signupModel.deleteUser();
    goSignUp();
  }

  // 이메일 인증이 되었는지 확인
  void checkEmail() async {
    EasyLoading.show();
    String? uid = await getUID();
    signupModel.setUid(uid!);
    bool checkEmail = await signupModel.checkEmail(id);

    if (checkEmail) {
      showSimpleSnackbar(
          '이메일 인증 완료', '이메일 인증이 완료되었습니다! 로그인 후 서비스를 이용해 주세요.', SnackPosition.TOP, Colors.black);
      goSignUp();
    } else {
      showSimpleDialog(Get.back, '인증 확인 오류', '이메일 인증이 완료되지 않았습니다. 이메일을 확인하고 인증 링크를 클릭하세요.');
    }
    EasyLoading.dismiss();
  }

  // 인증 이메일을 다시 보냄
  void reSendEmail() async {
    EasyLoading.show();
    final sendEmail = await signupModel.sendEmail(id, pw);
    if (sendEmail) {
      showSimpleDialog(Get.back, '전송 완료', '이메일 재전송에 성공하였습니다.');
    } else {
      showSimpleDialog(Get.back, '회원가입 오류', '이메일 전송에 실패했습니다. 다시 시도해 주세요.');
    }
    EasyLoading.dismiss();
  }
}
