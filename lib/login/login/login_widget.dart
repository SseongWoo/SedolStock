import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';
import 'login_system.dart';

// 로그인 메인 위젯
class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final ScreenController _screenController = Get.find<ScreenController>();
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: loginController.controllerID,
          maxLines: 1,
          decoration: const InputDecoration(
            labelText: '아이디',
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.next,
        ),
        SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(4),
        ),
        TextField(
          controller: loginController.controllerPassword,
          obscureText: true,
          maxLines: 1,
          decoration: const InputDecoration(
            labelText: '비밀번호',
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.go,
        ),
        SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(4),
        ),
        SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(5),
          width: _screenController.screenSize.value.getWidthPerSize(80),
          child: ElevatedButton(
            onPressed: () {
              loginController.tryLogin(
                  loginController.controllerID.text, loginController.controllerPassword.text);
            },
            child: Text(
              '로그인',
              style: TextStyle(
                color: colorISEGYEIDOL,
                fontSize: _screenController.screenSize.value.getHeightPerSize(1.5),
              ),
            ),
          ),
        ),
        SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(4),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(4),
              child: TextButton(
                onPressed: () async {
                  loginController.goFindAccount();
                },
                child: Text(
                  '비밀번호 찾기',
                  style: TextStyle(
                    color: colorISEGYEIDOL,
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(4),
              child: TextButton(
                onPressed: () {
                  loginController.goSignUp();
                },
                child: Text(
                  '회원 가입',
                  style: TextStyle(
                    color: colorISEGYEIDOL,
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
