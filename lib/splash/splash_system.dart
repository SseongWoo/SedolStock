import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stockpj/login/login/login_screen.dart';
import 'package:stockpj/utils/http_request.dart';
import 'package:stockpj/utils/simple_widget.dart';
import '../login/login/login_system.dart';
import '../main/main_screen.dart';
import '../utils/get_data.dart';
import '../utils/secure_storage.dart';

class SplashController extends GetxController {
  RxString loadingMessage = RxString('로딩');

  void goLogin() {
    Get.offAll(() => LoginScreen(), binding: LoginBinding(), transition: Transition.noTransition);
  }

  void goHome() {
    Get.offAllNamed('/main');
    //Get.offAll(() => MainScreen(), transition: Transition.noTransition);
  }

  Future<bool> checkServer() async {
    try {
      // 서버에 간단한 GET 요청 보내기
      final running = await http.get(Uri.parse('$httpURL/running'));

      // 서버가 200 응답을 반환하면 서버가 정상적으로 실행 중임을 확인
      if (running.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> tryAutoLogin() async {
    Map<String, dynamic>? jsonData;
    try {
      String? refreshToken = await getRefreshToken();
      String? idToken = await getIdToken();

      final refreshTokenLogin = await http.post(
        Uri.parse('$httpURL/signin/tokenlogin'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'idToken': idToken, "refreshToken": refreshToken}),
      );
      if (refreshTokenLogin.statusCode == 401 || refreshTokenLogin.statusCode == 400) {
        throw Exception('Token or Refresh Token is missing.');
      } else {
        loadingMessage.value = '로그인중';
        jsonData = jsonDecode(refreshTokenLogin.body);
        await setUid(jsonData?['uid']);
        await setIdToken(jsonData?['idToken']);
        bool checkMyData = await getUserData();
        if (checkMyData) {
          loadingMessage.value = '마무리중';
          await Future.delayed(const Duration(seconds: 1));
          goHome();
        } else {
          throw Exception('MyData is missing.');
        }
      }
    } catch (error) {
      showSimpleSnackbar(
          '로그인 오류', '로그인을 처리하는데 문제가 발생하였습니다.\n로그인을 다시 시도해주세요', SnackPosition.TOP, Colors.black);
      await Future.delayed(const Duration(seconds: 3));
      goLogin();
    }
  }

  void checkVersion() {
    // 추후에 추가 예정
  }
  void splash() async {
    loadingMessage.value = '서버 상태 확인중';
    bool runnintServer = await checkServer();
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

  void closeApp() {
    exit(0);
  }
}
