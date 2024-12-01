import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:stockpj/splash/splash_system.dart';
import 'package:stockpj/utils/color.dart';
import '../utils/screen_size.dart';

// 앱 실행 로딩 화면
class SplashScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final SplashController _splashController = Get.put(SplashController());
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: colorISEGYEIDOL,
      child: Padding(
        padding: EdgeInsets.only(
            top: _screenController.screenSize.value.getHeightPerSize(20),
            bottom: _screenController.screenSize.value.getHeightPerSize(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(20),
              width: _screenController.screenSize.value.getHeightPerSize(20),
              color: colorIfari,
            ),
            const Spacer(),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(10),
              width: _screenController.screenSize.value.getHeightPerSize(10),
              child: const SpinKitRing(
                color: Colors.white,
              ),
            ),
            Obx(
              () => Text(
                _splashController.loadingMessage.value,
                style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
