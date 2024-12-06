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
        SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(2),
        ),
        TextField(
          controller: loginController.controllerID,
          maxLines: 1,
          decoration: InputDecoration(
            labelText: '아이디',
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorIfari, width: 2.0),
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.next,
        ),
        SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(2),
        ),
        TextField(
          controller: loginController.controllerPassword,
          obscureText: true,
          maxLines: 1,
          decoration: InputDecoration(
            labelText: '비밀번호',
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorIfari, width: 2.0),
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.go,
        ),
        SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(4),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(3.5),
              child: Image.asset('assets/image/ui/bolt1.png'),
            ),
            const Spacer(),
            Obx(
              () => SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(4.5),
                width: _screenController.screenSize.value.getWidthPerSize(55),
                child: ElevatedButton(
                  onPressed: () {
                    loginController.tryLogin(
                        loginController.controllerID.text, loginController.controllerPassword.text);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: colorIfari),
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      color: colorSUB,
                      fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(3.5),
              child: Image.asset('assets/image/ui/bolt2.png'),
            ),
          ],
        ),
        SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(2),
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
                    color: colorIfari,
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
                    color: colorIfari,
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
