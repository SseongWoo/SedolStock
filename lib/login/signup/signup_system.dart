import 'package:get/get.dart';
import 'package:stockpj/login/signup/signup_checkemail_screen.dart';
import 'package:stockpj/login/signup/signup_setprofile_screen.dart';

void goSignUpCheckEmail(String email) {
  Get.offAll(() => SignupCheckemailScreen(), arguments: email);
}

void goSignUpSetProfile() {
  Get.offAll(() => const SignupSetprofileScreen());
}
