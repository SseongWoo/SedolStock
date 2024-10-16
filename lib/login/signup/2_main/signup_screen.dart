import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/2_main/signup_widget.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';

class SignUpScreen extends StatelessWidget {
  final ScreenController _screenController = Get.put(ScreenController());
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool email = Get.arguments;
    _screenController.updateScreenSize(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorStelLive,
        title: const Text('회원가입'),
      ),
      body: SingleChildScrollView(
        child: SignUpWidget(
          email: email,
        ),
      ),
    );
  }
}
