import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/login/login_widget.dart';
import '../../data/public_data.dart';
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
      backgroundColor: colorMAIN,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(18),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(20),
              width: _screenController.screenSize.value.getWidthPerSize(80),
              child: Image.asset('assets/image/title.png'),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(38),
              width: _screenController.screenSize.value.getWidthPerSize(94),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image/ui/login.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(_screenController.screenSize.value.getWidthPerSize(8),
                    0, _screenController.screenSize.value.getWidthPerSize(8), 0),
                child: const LoginWidget(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: _screenController.screenSize.value.getWidthPerSize(6),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'ver.$appVersion+$appBuild',
                  style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                      fontFamily: 'Dot'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
