import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:stockpj/main/information/setting/setting_screen.dart';
import 'package:stockpj/main/information/withdrawal/withdrawal_screen.dart';
import '../../data/my_data.dart';
import '../../data/public_data.dart';
import '../../utils/data_storage.dart';
import '../../utils/get_env.dart';
import '../../utils/simple_widget.dart';
import 'information_widget.dart';
import 'package:http/http.dart' as http;

class MoneyChartClass {
  String name;
  int money;

  MoneyChartClass(this.name, this.money);
}

class InformationController extends GetxController {
  final MyDataController _myDataController = Get.find<MyDataController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  RxInt minValue = 0.obs;
  RxDouble rate = 0.0.obs;
  RxList<MoneyChartClass> moneyChartList = <MoneyChartClass>[].obs;
  final TextEditingController controllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final filter = ProfanityFilter();
  bool overlapName = false;
  RxInt dialogIndex = 0.obs;

  void test() async {
    print(rate);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setMinValue();
    profitRate();
    setMoneyChartData();

    dialogIndex.value = streamerIndexMap[_myDataController.myChoicechannel.value]!;
  }

  void setMoneyChartData() {
    moneyChartList.clear();
    moneyChartList.add(MoneyChartClass('현금 자산', _myDataController.myMoney.value));
    moneyChartList.add(MoneyChartClass('주식 자산', _myDataController.myStockMoney.value));
  }

  void setMinValue() {
    int minV = _myDataController.totalMoneyHistoryList.reduce(min);

    if (minV > 10000) {
      minValue.value = (minV ~/ 10000) * 10000;
    } else {
      minValue.value = 0;
    }
  }

  void profitRate() {
    if (_myDataController.totalMoneyHistoryList.length > 1) {
      rate.value = (((_myDataController.myTotalMoney.value -
                  _myDataController
                      .totalMoneyHistoryList[_myDataController.totalMoneyHistoryList.length - 2]) /
              _myDataController
                  .totalMoneyHistoryList[_myDataController.totalMoneyHistoryList.length - 2]) *
          100);
      rate.value = double.parse(rate.value.toStringAsFixed(2));
    } else {
      rate.value = 0.0;
    }
  }

  void nameChange() {
    Get.dialog(NameChangeDialog()).then(
      (value) => controllerName.clear(),
    );
  }

  void channelChange() {
    Get.dialog(ChannelChangeDialog()).then(
      (value) => dialogIndex.value = streamerIndexMap[_myDataController.myChoicechannel.value]!,
    );
  }

  void goSetting() {
    Get.to(() => SettingScreen());
  }

  Future<void> updateUserName() async {
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
      print('${_myDataController.myName.value} : ${controllerName.text}');
      showSimpleSnackbar('변경 완료', '닉네임 변경이 완료되었습니다', SnackPosition.TOP, Colors.black);
    } else {
      EasyLoading.dismiss();
      showSimpleSnackbar('변경 실패', '닉네임 변경에 실패하였습니다\n다시 시도해 주세요', SnackPosition.TOP, Colors.black);
    }
  }

  Future<void> updateFanName() async {
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
    }
  }

  void startLogOut() {
    Get.dialog(LogoutDialog());
  }

  void startPWChange() async {
    if (_myDataController.myId.contains('@') && _myDataController.myId.contains('.')) {
      await sendFindEmail();
    } else {
      showSimpleDialog(Get.back, '계정 오류', '현재 사용 중인 계정은 게스트 계정입니다.\n이 기능을 사용하려면 이메일 계정을 생성해 주세요.');
    }
  }

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
    } catch (error) {
      showSimpleDialog(Get.back, '오류', '이메일 전송에 실패했습니다.\n다시 시도해 주세요.');
    }
    EasyLoading.dismiss();
  }

  Future<void> restartUserData() async {
    EasyLoading.show(status: '초기화 중');
    String? uid = await getUID();
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
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
    }
  }

  Future<void> changePWData() async {
    EasyLoading.show(status: '초기화 중');
    String? uid = await getUID();
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
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
    }
  }
}
