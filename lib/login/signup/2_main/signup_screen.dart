import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/2_main/signup_widget.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';

// 회원가입 2단계 화면
class SignUpScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorISEGYEIDOL,
        title: const Text('회원가입'),
      ),
      body: const SingleChildScrollView(
        child: SignUpWidget(),
      ),
    );
  }
}
