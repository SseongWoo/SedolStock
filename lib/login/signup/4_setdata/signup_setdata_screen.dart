import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/4_setdata/signup_setdata_widget.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';

class SignupSetprofileScreen extends StatefulWidget {
  const SignupSetprofileScreen({super.key});

  @override
  State<SignupSetprofileScreen> createState() => _SignupSetprofileScreenState();
}

class _SignupSetprofileScreenState extends State<SignupSetprofileScreen> {
  final ScreenController _screenController = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        backgroundColor: colorStelLive,
        leading: const SignUpSetDataBackButtonWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getWidthPerSize(10)),
        child: Center(
          child: Column(
            children: [
              const SignUpSetDataTextWidget(),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(4),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '나는 ',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                    ),
                  ),
                  const SignUpDropDownWidget(),
                  Text(
                    ' 입니다',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(8),
              ),
              const SignUpSetDataButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
