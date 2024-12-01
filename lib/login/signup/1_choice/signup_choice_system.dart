import 'package:get/get.dart';
import '../2_main/signup_screen.dart';
import '../2_main/signup_system.dart';

class SingUpChoiceControll extends GetxController {
  // 회원가입 2단계로 이동
  void goSignUp(bool email) {
    Get.to(() => SignUpScreen(), binding: SignUpBinding(), arguments: email);
  }
}
