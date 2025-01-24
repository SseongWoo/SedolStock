import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../utils/screen_size.dart';
import '../constants/color_constants.dart';
import '../viewmodel/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  final SplashViewModel _viewModel = Get.put(SplashViewModel());
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _viewModel.screenController.updateScreenSize(context);
    // });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: colorIfari,
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.getWidthPerSize(15),
                ),
                child: Image.asset('assets/image/title.png'),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: screenSize.getHeightPerSize(10),
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.getHeightPerSize(10),
                    width: screenSize.getHeightPerSize(10),
                    child: const SpinKitRing(color: Colors.black),
                  ),
                  Obx(
                    () => Text(
                      _viewModel.loadingMessage.value,
                      style: TextStyle(
                        fontSize: screenSize.getHeightPerSize(2),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WindowsScreen extends StatelessWidget {
  final WindowsViewModel _viewModel = Get.put(WindowsViewModel());
  WindowsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
