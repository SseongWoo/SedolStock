import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main.dart';
import 'package:stockpj/view/splash_widget.dart';
import 'package:store_redirect/store_redirect.dart';
import '../constants/route_constants.dart';
import '../data/public_data.dart';
import '../data/my_data.dart';
import '../data/start_data.dart';
import '../service/http_service.dart';
import '../utils/check_list.dart';
import '../service/storage_service.dart';
import '../utils/screen_size.dart';
import '../widget/simple_widget.dart';
import '../model/splash_model.dart';
import 'dart:io' show Platform;
import '../../../utils/web_stub.dart'
    if (dart.library.html) '../../../utils/web_stub.dart'
    if (dart.library.io) '../../../utils/get_windows_size.dart';

// 로딩 화면 뷰 모델
class SplashViewModel extends GetxController {
  final SplashModel splashModel = SplashModel();
  final HttpService _httpService = HttpService();
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  RxString loadingMessage = RxString('로딩중'); // 로딩 메시지 상태

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
      bool needsUpdate = checkVersion(
          _publicDataController.appVersion.value, _publicDataController.storeVersion.value);

      // 업데이트가 있을경우
      if (needsUpdate) {
        Get.dialog(
          UpdateDialog(
            screenSize: screenController.screenSize.value,
            appVersion: _publicDataController.appVersion.value,
            newVersion: _publicDataController.storeVersion.value,
            onPressedUpdate: _goUpdate,
            onPressedCencle: _closeApp,
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
          screenController.screenSize.value, '서버 점검중', '서버 점검중입니다.\n앱을 종료합니다.', _closeApp, false);
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

  void _closeApp() {
    exit(0);
  }

  void _goUpdate() {
    GetPlatform.isMobile
        ? StoreRedirect.redirect()
        : _httpService.openUrl('https://waktaverse.games/gameDetail/sedol_stock',
            '오류가 발생했습니다. 네트워크 연결을 확인하거나, 다시 시도해주세요.');
  }
}

class WindowsViewModel extends GetxController {
  final ScreenController _screenController = Get.find<ScreenController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (GetPlatform.isWindows) {
      startGetWindowsSize();
    }
  }

  void startGetWindowsSize() async {
    int? windowsPer;

    windowsPer = await loadWindowsSizeData();
    _screenController.windowsMaxSize = getPhysicalScreenSize();
    setWindowsSize(windowsPer ?? 70);

    Get.offAllNamed(AppRoute.splash);
  }
}
