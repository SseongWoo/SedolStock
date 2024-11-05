import 'package:get/get.dart';
import '../2_main/signup_screen.dart';
import '../2_main/signup_system.dart';

class SingUpChoiceControll extends GetxController {
  void goSignUp(bool email) {
    Get.to(() => SignUpScreen(), binding: SignUpBinding(), arguments: email);
  }
}
