import 'package:get/get.dart';
import '../signup/signup_screen.dart';

class LoginController extends GetxController {
  void goSignUp() {
    Get.to(() => const SignupScreen());
  }
}
