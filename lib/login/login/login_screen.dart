import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/login/login_widget.dart';

import '../../utils/color.dart';
import '../../utils/screen_size.dart';
import 'login_system.dart';

class LoginScreen extends StatelessWidget {
  final ScreenController _screenController = Get.put(ScreenController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Scaffold(
      body: Center(
        child: Container(
          height: _screenController.screenSize.value.getHeightPerSize(40),
          width: _screenController.screenSize.value.getWidthPerSize(90),
          decoration: BoxDecoration(
            color: colorStelLiveLight,
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
