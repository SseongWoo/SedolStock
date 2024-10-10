import 'package:get/get.dart';
import 'package:stockpj/main/main_screen.dart';
import 'package:stockpj/login/find_account/find_account_screen.dart';
import '../signup/signup_screen.dart';

class LoginController extends GetxController {
  void goSignUp() {
    Get.to(() => const SignupScreen());
  }

  void goFindAccount() {
    Get.to(() => const FindAccountScreen());
  }

  void goHome() {
    Get.to(() => MainScreen());
  }
}
