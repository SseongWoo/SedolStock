import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/1_choice/signup_choice_system.dart';

import '../../../utils/screen_size.dart';

final SingUpChoiceControll _choiceControll = Get.put(SingUpChoiceControll());

// 회원가입 1단계 화면의 커스텀 버튼 위젯
class SignUpChoiceButtonWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final String title;
  final String value;
  final IconData icon;
  final bool email;
  SignUpChoiceButtonWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          _choiceControll.goSignUp(email);
        },
        child: SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(25),
          width: _screenController.screenSize.value.getWidthPerSize(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: _screenController.screenSize.value.getHeightPerSize(6),
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2.8),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.3),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
