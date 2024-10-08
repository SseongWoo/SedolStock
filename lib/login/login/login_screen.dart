import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color.dart';
import '../../utils/screen_size.dart';
import 'login_system.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerID = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final ScreenController screenController = Get.put(ScreenController());
  final LoginController loginController = Get.put(LoginController());

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerID.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenController.updateScreenSize(context);
    return Scaffold(
      body: Center(
        child: Container(
          height: screenController.screenSize.value.getHeightPerSize(40),
          width: screenController.screenSize.value.getWidthPerSize(90),
          decoration: BoxDecoration(
            color: colorStelLiveLight,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(screenController.screenSize.value.getWidthPerSize(5), 0,
                screenController.screenSize.value.getWidthPerSize(5), 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _controllerID,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: '아이디',
                  ),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: screenController.screenSize.value.getHeightPerSize(4),
                ),
                TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                  ),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  textInputAction: TextInputAction.go,
                ),
                SizedBox(
                  height: screenController.screenSize.value.getHeightPerSize(4),
                ),
                SizedBox(
                  height: screenController.screenSize.value.getHeightPerSize(5),
                  width: screenController.screenSize.value.getWidthPerSize(80),
                  child: ElevatedButton(
                    onPressed: () async {},
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        color: colorStelLive,
                        fontSize: screenController.screenSize.value.getHeightPerSize(1.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenController.screenSize.value.getHeightPerSize(4),
                ),
                SizedBox(
                  height: screenController.screenSize.value.getHeightPerSize(4),
                  child: TextButton(
                    onPressed: () {
                      loginController.goSignUp();
                    },
                    child: Text(
                      '회원 가입',
                      style: TextStyle(
                        color: colorStelLive,
                        fontSize: screenController.screenSize.value.getHeightPerSize(1.4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
