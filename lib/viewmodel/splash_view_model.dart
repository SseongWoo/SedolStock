import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main.dart';
import 'package:stockpj/view/splash_widget.dart';
import 'package:store_redirect/store_redirect.dart';
import '../constants/route_constants.dart';
import '../data/public_data.dart';
import '../data/my_data.dart';
import '../data/start_data.dart';
import '../utils/check_list.dart';
import '../service/storage_service.dart';
import '../utils/screen_size.dart';
import '../widget/simple_widget.dart';
import '../model/splash_model.dart';

// 로딩 화면 뷰 모델
class SplashViewModel extends GetxController {
  final SplashModel splashModel = SplashModel();
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  RxString loadingMessage = RxString('로딩'); // 로딩 메시지 상태

  @override
  void onInit() {
    super.onInit();
    initializeSplash();
  }

  // 로딩
  Future<void> initializeSplash() async {
    loadingMessage.value = '서버 상태 확인중';
    bool isServerRunning = await checkServer();

    // 서버가 구동중일경우
    if (isServerRunning) {
      loadingMessage.value = '앱 버전 확인중';
      await _publicDataController.getAppVersion();
      bool needsUpdate = _checkVersion();

      // 업데이트가 있을경우
      if (needsUpdate) {
        Get.dialog(
          UpdateDialog(
            screenSize: screenController.screenSize.value,
            onPressedCencle: _closeApp,
            onPressedUpdate: StoreRedirect.redirect,
          ),
        );
      } else {
        loadingMessage.value = '로그인 확인중';
        String? token = await getRefreshToken();

        if (token != null) {
          loadingMessage.value = '사용자 정보를 불러오는 중';
          await _handleAutoLogin();
        } else {
          goToLogin();
        }
      }
    } else {
      showSimpleDialog2(
          screenController.screenSize.value, '서버 점검중', '서버 점검중입니다.\n앱을 종료합니다.', _closeApp);
    }
  }

  // 자동 로그인
  Future<void> _handleAutoLogin() async {
    try {
      final loginData = await splashModel.tryAutoLogin();
      await setUid(loginData.uid);
      await setIdToken(loginData.token);
      bool hasUserData = await _myDataController.getUserData();
      bool hasWalletData = await _myDataController.getWalletData();

      if (hasUserData && hasWalletData) {
        loadingMessage.value = '마무리 중';
        await startGetData();
        goToHome();
      } else {
        throw Exception('User data is incomplete.');
      }
    } catch (e) {
      logger.e(e);
      await setIdToken(null);
      await setTokens(null, null);
      _handleLoginError();
    }
  }

  // 자동로그인에서 문제발생했을시
  void _handleLoginError() {
    showSimpleSnackbar(
      '로그인 오류',
      '로그인을 처리하는데 문제가 발생하였습니다.\n로그인을 다시 시도해주세요\n',
      SnackPosition.TOP,
      Colors.black,
    );
    Future.delayed(const Duration(seconds: 3), () => goToLogin());
  }

  void goToLogin() {
    Get.offAllNamed(AppRoute.signin);
  }

  void goToHome() {
    Get.offAllNamed(AppRoute.home);
  }

  // 앱 버전과 최소 요구 버전 비교
  bool _checkVersion() {
    final isVersionOutdated = _isVersionLower();
    final isBuildOutdated = int.parse(_publicDataController.storeBuild.value) >
        int.parse(_publicDataController.appBuild.value);

    return (isVersionOutdated || isBuildOutdated);
  }

  bool _isVersionLower() {
    final appParts = _publicDataController.appVersion.split('.').map(int.parse).toList();
    final storeParts = _publicDataController.storeVersion.split('.').map(int.parse).toList();
    for (int i = 0; i < appParts.length; i++) {
      if (storeParts[i] > appParts[i]) return true; // 현재 버전이 최소 요구 버전보다 낮음
      if (storeParts[i] < appParts[i]) return false; // 현재 버전이 더 높음
    }
    return false; // 버전이 같음
  }

  void _closeApp() {
    exit(0);
  }
}

class WindowsViewModel extends GetxController {
  final ScreenController _screenController = Get.find<ScreenController>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startGetWindowsSize();
  }

  void startGetWindowsSize() async {
    await DesktopWindow.setFullScreen(true);
    _screenController.windowsSize = await DesktopWindow.getWindowSize();
    await DesktopWindow.setFullScreen(false);

    double targetHeight = _screenController.windowsSize.height * 0.8;
    double targetWidth = targetHeight * (9 / 19.5);

    await DesktopWindow.setWindowSize(Size(targetWidth, targetHeight));
    await DesktopWindow.setMaxWindowSize(Size(targetWidth, targetHeight));
    await DesktopWindow.setMinWindowSize(Size(targetWidth, targetHeight));

    Get.offAllNamed(AppRoute.splash);
  }
}
