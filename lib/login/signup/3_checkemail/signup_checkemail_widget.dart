import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/3_checkemail/signup_checkemail_system.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';

class SignUpReSendEmailWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  SignUpReSendEmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SingUpCheckEmailControll _singUpCheckEmailControll = Get.find<SingUpCheckEmailControll>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '메일이 도착하지 않았나요? 다시 전송하시겠습니까?',
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(1.3),
          ),
        ),
        TextButton(
          onPressed: () {
            _singUpCheckEmailControll.sendEmail();
          },
          child: Text(
            '재전송',
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(1.3),
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpCheckEmailButtonWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final SingUpCheckEmailControll _singUpCheckEmailControll = Get.find<SingUpCheckEmailControll>();
  SignUpCheckEmailButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _screenController.screenSize.value.getWidthPerSize(50),
      child: ElevatedButton(
        onPressed: () {
          _singUpCheckEmailControll.checkEmail();
          //_singUpCheckEmailControll.goSignUpSetProfile();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorISEGYEIDOLLight, // 버튼 배경색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // 버튼을 둥글게 만들어 FAB 느낌을 줌
          ),
          padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이를 조절
        ),
        child: Text(
          '이메일 주소 인증 완료',
          style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
        ),
      ),
    );
  }
}
