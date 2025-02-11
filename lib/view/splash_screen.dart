import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
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

class WaktaverseGames extends StatelessWidget {
  const WaktaverseGames({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaktaverseGamesViewModel>(
      init: WaktaverseGamesViewModel(), // 뷰모델 초기화
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black, // 검은 배경
          body: GestureDetector(
            onTap: controller.goToSplash,
            child: Center(
              child: controller.videoController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: controller.videoController.value.aspectRatio,
                      child: VideoPlayer(controller.videoController), // 재생 바 없음
                    )
                  : const CircularProgressIndicator(
                      color: Colors.white,
                    ), // 로딩 표시
            ),
          ),
        );
      },
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
