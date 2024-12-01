import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/login/login_widget.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';

// 로그인 화면
class LoginScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
      body: Center(
        child: Container(
          height: _screenController.screenSize.value.getHeightPerSize(40),
          width: _screenController.screenSize.value.getWidthPerSize(80),
          decoration: BoxDecoration(
            color: colorISEGYEIDOLLight,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(_screenController.screenSize.value.getWidthPerSize(5), 0,
                _screenController.screenSize.value.getWidthPerSize(5), 0),
            child: const LoginWidget(),
          ),
        ),
      ),
    );
  }
}
