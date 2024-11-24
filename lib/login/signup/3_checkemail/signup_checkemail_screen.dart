import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/3_checkemail/signup_checkemail_system.dart';
import 'package:stockpj/login/signup/3_checkemail/signup_checkemail_widget.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';

class SignupCheckemailScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final SingUpCheckEmailControll _singUpCheckEmailControll = Get.put(SingUpCheckEmailControll());
  SignupCheckemailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorISEGYEIDOL,
        leading: IconButton(
            onPressed: () {
              _singUpCheckEmailControll.cancelSignUp();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text('회원가입'),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          _screenController.screenSize.value.getHeightPerSize(3),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                '이메일 주소 인증',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(3),
              ),
              Text(
                '${_singUpCheckEmailControll.email}님,\n\n인증 이메일을 발송했습니다. 메일을 확인하시고 링크를 클릭하여 인증을 완료해 주세요. 감사합니다.',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(5),
              ),
              SignUpCheckEmailButtonWidget(),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(5),
              ),
              const Divider(
                color: Colors.grey, // 구분선 색상
                thickness: 1, // 구분선 두께
              ),
              SignUpReSendEmailWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
