import 'dart:convert';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:stockpj/main/information/setting/setting_screen.dart';
import 'package:stockpj/main/information/withdrawal/withdrawal_screen.dart';
import '../../data/my_data.dart';
import '../../data/public_data.dart';
import '../../main.dart';
import '../../utils/data_storage.dart';
import '../../utils/format.dart';
import '../../utils/get_env.dart';
import '../../utils/simple_widget.dart';
import 'information_widget.dart';
import 'package:http/http.dart' as http;

// 정보 화면 사용자 자산 변동 그래프를 위한 클래스
class MoneyChartClass {
  String name;
  int money;

  MoneyChartClass(this.name, this.money);
}

class InformationController extends GetxController {
  final MyDataController _myDataController = Get.find<MyDataController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  RxInt minValue = 0.obs; // 그래프의 y축 최소값을 지정하기 위한 변수
  RxDouble rate = 0.0.obs; // 사용자의 자산 변동률 변수
  RxList<MoneyChartClass> moneyChartList = <MoneyChartClass>[].obs; // 사용자의 자산 차트 값 리스트
  final TextEditingController controllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final filter = ProfanityFilter(); // 비속어를 감지하는 필터
  bool overlapName = false; // 사용자의 이름 중복 확인
  RxInt dialogIndex = 0.obs;
  RxInt maxValue = 0.obs; // 자산 차트 값 중 가장 높은 값을 10000단위로 올림한 값
  List<FlSpot> get chartSpots {
    final list = _myDataController.totalMoneyHistoryList
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.toDouble(),
            ))
        .toList();

    // 리스트의 마지막 10개의 값만 가져오기
    final last10 = list.length > 10 ? list.sublist(list.length - 10) : list;

    // x 값을 0부터 다시 설정
    return last10.asMap().entries.map((entry) {
      final index = entry.key; // 새로운 인덱스
      final spot = entry.value;
      return FlSpot(index.toDouble(), spot.y); // x 값을 0부터 다시 설정
    }).toList();
  }

  void startController() {
    profitRate();
    setMoneyChartData();
    dialogIndex.value = streamerIndexMap[_myDataController.myChoicechannel.value]!;
  }

  // 차트 데이터 설정 함수
  void setMoneyChartData() {
    moneyChartList.clear();
    moneyChartList.add(MoneyChartClass('현금 자산', _myDataController.myMoney.value));
    moneyChartList.add(MoneyChartClass('주식 자산', _myDataController.myStockMoney.value));
  }

  // 사용자의 자산 변동률을 계산하는 함수
  void profitRate() {
    if (_myDataController.totalMoneyHistoryList.length > 1) {
      rate.value = (((_myDataController.myTotalMoney.value -
                  _myDataController
                      .totalMoneyHistoryList[_myDataController.totalMoneyHistoryList.length - 2]) /
              _myDataController
                  .totalMoneyHistoryList[_myDataController.totalMoneyHistoryList.length - 2]) *
          100);
      rate.value = double.parse(
        rate.value.toStringAsFixed(2),
      );
      if (rate.value > -0.01 && rate.value < 0.01) {
        rate.value = 0.0;
      }
    } else {
      rate.value = 0.0;
    }
  }

  // 사용자의 이름 변경을 위한 다이얼로그 호출 함수
  void nameChange() {
    Get.dialog(NameChangeDialog()).then(
      (value) => controllerName.clear(),
    );
  }

  // 사용자가 설정한 팬덤명을 변경하기 위해 다이얼로그를 호출하는 함수
  void channelChange() {
    Get.dialog(ChannelChangeDialog()).then(
      (value) => dialogIndex.value = streamerIndexMap[_myDataController.myChoicechannel.value]!,
    );
  }

  // 관리 화면으로 이동하는 함수
  void goSetting() {
    Get.to(() => SettingScreen());
  }

  // 사용자의 이름을 업데이트 하는 함수
  Future<void> updateUserName() async {
    try {
      EasyLoading.show(status: '사용자 데이터 등록중');
      final userData = await http.put(
        Uri.parse('$httpURL/names/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uid': _myDataController.myUid.value,
          'name': _myDataController.myName.value,
          'newname': controllerName.text,
        }),
      );

      Get.back();
      if (userData.statusCode == 200) {
        EasyLoading.dismiss();
        _myDataController.myName.value = controllerName.text;
        showSimpleSnackbar('변경 완료', '닉네임 변경이 완료되었습니다', SnackPosition.TOP, Colors.black);
      } else {
        EasyLoading.dismiss();
        showSimpleSnackbar('변경 실패', '닉네임 변경에 실패하였습니다\n다시 시도해 주세요', SnackPosition.TOP, Colors.black);
        logger.w('updateUserName error');
      }
    } catch (e) {
      EasyLoading.dismiss();
      showSimpleSnackbar('변경 실패', '닉네임 변경에 실패하였습니다\n다시 시도해 주세요', SnackPosition.TOP, Colors.black);
      logger.e('updateUserName error : $e');
    }
  }

  // 사용자가 설정한 팬덤명을 변경하는 함수
  Future<void> updateFanName() async {
    try {
      EasyLoading.show(status: '팬네임 변경중');
      final userData = await http.put(
        Uri.parse('$httpURL/fanname/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uid': _myDataController.myUid.value,
          'name': fanNameList[dialogIndex.value],
        }),
      );

      Get.back();
      if (userData.statusCode == 200) {
        EasyLoading.dismiss();
        _myDataController.myChoicechannel.value = fanNameList[dialogIndex.value];
        showSimpleSnackbar('변경 완료', '팬네임 변경이 완료되었습니다', SnackPosition.TOP, Colors.black);
      } else {
        EasyLoading.dismiss();
        showSimpleSnackbar('변경 실패', '팬네임 변경에 실패하였습니다\n다시 시도해 주세요', SnackPosition.TOP, Colors.black);
        logger.w('updateFanName error');
      }
    } catch (e) {
      EasyLoading.dismiss();
      showSimpleSnackbar('변경 실패', '팬네임 변경에 실패하였습니다\n다시 시도해 주세요', SnackPosition.TOP, Colors.black);
      logger.e('updateFanName error : $e');
    }
  }

  // 로그아웃을 하기위한 다이얼로그를 호출하는 함수
  void startLogOut() {
    Get.dialog(LogoutDialog());
  }

  // 사용자의 비밀번호를 변경하는 함수
  void startPWChange() async {
    if (_myDataController.myId.contains('@') && _myDataController.myId.contains('.')) {
      await sendFindEmail();
    } else {
      showSimpleDialog(Get.back, '계정 오류', '현재 사용 중인 계정은 게스트 계정입니다.\n이 기능을 사용하려면 이메일 계정을 생성해 주세요.');
    }
  }

  // 계정 비밀번호 변경을 위한 이메일 전송 함수
  Future<void> sendFindEmail() async {
    EasyLoading.show(status: '확인중');
    try {
      if (!_myDataController.myId.value.contains('@') ||
          !_myDataController.myId.value.contains('.')) {
        throw Exception('error');
      }

      final response = await http.post(
        Uri.parse('$httpURL/users/reset'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': _myDataController.myId.value}),
      );

      if (response.statusCode == 200) {
        Get.dialog(ChangePWDialog());
      } else {
        throw Exception('error');
      }
    } catch (e) {
      showSimpleDialog(Get.back, '오류', '이메일 전송에 실패했습니다.\n다시 시도해 주세요.');
      logger.e('sendFindEmail error : $e');
    }
    EasyLoading.dismiss();
  }

  // 계정 정보 초기화 함수(파산 신청)
  Future<void> restartUserData() async {
    EasyLoading.show(status: '초기화 중');
    try {
      String uid = _myDataController.myUid.value;
      if (uid == '') {
        throw Exception('uid is empty');
      }

      final userData = await http.put(
        Uri.parse('$httpURL/users/restart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uid': uid.toString(),
        }),
      );

      if (userData.statusCode == 201) {
        showSimpleSnackbar('초기화 성공', '초기화에 성공했습니다. 다시 로그인해주세요.', SnackPosition.TOP, Colors.black);
        _publicDataController.logOut();
      } else {
        showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
      }
    } catch (e) {
      showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
      logger.e('restartUserData error : $e');
    }
    EasyLoading.dismiss();
  }
}
