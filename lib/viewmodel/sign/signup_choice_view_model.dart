import 'package:get/get.dart';
import 'package:stockpj/config/route.dart';
import '../../utils/screen_size.dart';

// 회원가입 1단계 뷰모델
class SignupChoiceViewModel extends GetxController {
  final ScreenController screenController = Get.find<ScreenController>();
  // 다음 화면으로 이동
  void goSignUp(bool email) {
    Get.toNamed(
      AppRoute.signupScreen,
      arguments: email,
    );
  }
}
