import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/1_choice/signup_choice_widget.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';

// 회원가입 1단계 화면
class SignUpChoiceScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  SignUpChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
      backgroundColor: colorMAIN,
      appBar: AppBar(
        backgroundColor: colorMAIN,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: _screenController.screenSize.value.getHeightPerSize(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SignUpChoiceButtonWidget(
                email: true,
                title: '이메일 회원가입',
                value: '이메일로 가입하시면 계정 찾기와 비밀번호 재설정이 가능합니다.',
              ),
              SignUpChoiceButtonWidget(
                email: false,
                title: '게스트 회원가입',
                value: '게스트로 이메일 없이 사용 가능하지만, 계정 복구는 불가능합니다.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
