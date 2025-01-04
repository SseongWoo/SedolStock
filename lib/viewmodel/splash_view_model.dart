import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main.dart';
import 'package:store_redirect/store_redirect.dart';
import '../config/route.dart';
import '../data/public_data.dart';
import '../data/my_data.dart';
import '../data/start_data.dart';
import '../utils/check_list.dart';
import '../utils/data_storage.dart';
import '../utils/screen_size.dart';
import '../widget/simple_widget.dart';
import '../model/splash_model.dart';

class SplashViewModel extends GetxController {
  final SplashModel splashModel = SplashModel();
  final ScreenController screenController = Get.find<ScreenController>();
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

    loadingMessage.value = '앱 버전 확인중';
    await getAppVersion();
    bool needsUpdate = _checkVersion();

    if (needsUpdate) {
      _updateDialog();
    } else {
      loadingMessage.value = '로그인 확인중';
      String? token = await getRefreshToken();

      if (isServerRunning) {
        if (token != null) {
          loadingMessage.value = '사용자 정보를 불러오는 중';
          await _handleAutoLogin();
        } else {
          goToLogin();
        }
      } else {
        showSimpleDialog(_closeApp, '서버 점검중', '서버 점검중입니다.\n앱을 종료합니다.');
      }
    }
  }

  // 자동 로그인
  Future<void> _handleAutoLogin() async {
    try {
      final loginData = await splashModel.tryAutoLogin();
      await setUid(loginData.uid);
      await setIdToken(loginData.token);
      bool hasUserData = await getUserData();
      bool hasWalletData = await getWalletData();

      if (hasUserData && hasWalletData) {
        loadingMessage.value = '마무리 중';
        await startGetData();
        goToHome();
      } else {
        throw Exception('User data is incomplete.');
      }
    } catch (e) {
      logger.e(e);
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
    final isBuildOutdated = int.parse(storeBuild) > int.parse(appBuild);

    return (isVersionOutdated || isBuildOutdated);
  }

  void _updateDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('업데이트'),
        content: const Text('최신 버전으로 업데이트가 필요합니다.'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _closeApp();
                },
                child: const Text('취소'),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    StoreRedirect.redirect();
                  },
                  child: const Text('업데이트'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  bool _isVersionLower() {
    final appParts = appVersion.split('.').map(int.parse).toList();
    final storeParts = storeVersion.split('.').map(int.parse).toList();
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
