import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../main.dart';
import '../service/http_service.dart';
import '../widget/simple_widget.dart';
import 'package:get/get.dart';
import 'logout.dart';

// 계정 정보 초기화 함수(파산 신청)
Future<bool> _restartUserData(String uid, int level) async {
  final HttpService httpService = HttpService();
  try {
    if (uid == '') {
      throw Exception('uid is empty');
    }
    final userData = await httpService.putRequest('/users/restart', {'uid': uid, 'level': level});

    if (userData.statusCode == 201) {
      return true;
    } else {
      throw Exception(userData.statusCode);
    }
  } catch (e) {
    logger.e('restartUserData error : $e');
    return false;
  }
}

// 파산 신청
void restartDialog(ScreenSize screenSize, String uid, int level) {
  showSimpleDialog3(
      screenSize,
      '파산 신청',
      '파산 신청을 진행하시겠습니까?\n파산을 신청하면 모든 데이터가 초기화되며, 자동으로 로그아웃됩니다. 이 작업은 되돌릴 수 없으니 신중하게 결정해 주세요.',
      '파산 신청',
      () => _restart(uid, level));
}

// 계정 정보 초기화 함수(파산 신청)
void _restart(String uid, int level) async {
  EasyLoading.show(status: '초기화 중');
  bool restart = await _restartUserData(uid, level);

  if (restart) {
    showSimpleSnackbar('초기화 성공', '초기화에 성공했습니다. 다시 로그인해주세요.', SnackPosition.TOP, Colors.black);
    logOut();
  } else {
    showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
  }
  EasyLoading.dismiss();
}
