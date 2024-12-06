import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stockpj/data/start_data.dart';
import 'package:stockpj/login/login/login_screen.dart';
import 'package:stockpj/main.dart';
import 'package:stockpj/utils/get_env.dart';
import 'package:stockpj/utils/simple_widget.dart';
import '../data/public_data.dart';
import '../login/login/login_system.dart';
import '../data/my_data.dart';
import '../utils/check_list.dart';
import '../utils/data_storage.dart';

class SplashController extends GetxController {
  RxString loadingMessage = RxString('로딩'); // 로딩 메세지

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    splash();
  }

  // 로그인 화면으로 이동
  void goLogin() {
    Get.offAll(() => LoginScreen(), binding: LoginBinding(), transition: Transition.noTransition);
  }

  // 메인 화면으로 이동
  void goHome() {
    Get.offAllNamed('/main');
  }

  // 자동 로그인 기능 실행 함수
  Future<void> tryAutoLogin() async {
    Map<String, dynamic>? jsonData;
    try {
      String? refreshToken = await getRefreshToken();
      String? idToken = await getIdToken();

      if (refreshToken == null) {
        throw Exception('token empty');
      }

      final refreshTokenLogin = await http.post(
        Uri.parse('$httpURL/signin/tokenlogin'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'idToken': idToken, "refreshToken": refreshToken}),
      );
      if (refreshTokenLogin.statusCode == 401 || refreshTokenLogin.statusCode == 500) {
        throw Exception('Token or Refresh Token is missing.');
      } else {
        loadingMessage.value = '로그인중';
        jsonData = jsonDecode(refreshTokenLogin.body);
        await setUid(jsonData?['uid']);
        await setIdToken(jsonData?['idToken']);
        bool checkMyData = await getUserData();
        bool checkMyWalletData = await getWalletData();
        if (checkMyData && checkMyWalletData) {
          loadingMessage.value = '마무리중';
          await startGetData();
          await Future.delayed(const Duration(seconds: 1));
          goHome();
        } else {
          throw Exception('MyData is missing.');
        }
      }
    } catch (e) {
      showSimpleSnackbar(
          '로그인 오류', '로그인을 처리하는데 문제가 발생하였습니다.\n로그인을 다시 시도해주세요', SnackPosition.TOP, Colors.black);
      logger.e('tryAutoLogin error : $e');
      await Future.delayed(const Duration(seconds: 3));
      goLogin();
    }
  }

  // 로딩 함수, 데이터를 서버에서 받아오는 기능
  void splash() async {
    loadingMessage.value = '서버 상태 확인중';
    bool runnintServer = await checkServer();
    loadingMessage.value = '앱 버전 확인중';
    await getAppVersion();
    loadingMessage.value = '로그인 확인중';
    String? token = await getRefreshToken();

    if (runnintServer) {
      if (token != null) {
        loadingMessage.value = '사용자 정보를 불러오는중';
        await tryAutoLogin();
      } else {
        goLogin();
      }
    } else {
      showSimpleDialog(closeApp, '서버 점검중', '서버 점검중입니다.\n앱을 종료합니다.');
    }
  }

  // 앱 종료 기능
  void closeApp() {
    exit(0);
  }
}
