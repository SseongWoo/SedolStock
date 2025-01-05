import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:korean_profanity_filter/korean_profanity_filter.dart' as korean_filter;
import 'package:profanity_filter/profanity_filter.dart' as english_filter;
import 'package:stockpj/constants/route_constants.dart';
import '../../../constants/data_constants.dart';
import '../../../data/my_data.dart';
import '../../../data/public_data.dart';
import '../../../main.dart';
import '../../../model/main/information_model.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/search_name.dart';
import '../../../widget/simple_widget.dart';
import '../../../view/main/information/information_widget.dart';

class InformationViewModel extends GetxController {
  final InformationModel informationModel = InformationModel();
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  final TextEditingController controllerName = TextEditingController();
  List<FlSpot> get chartSpots {
    final list = myDataController.totalMoneyHistoryList
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.toDouble(),
            ))
        .toList();

    final totalMoney =
        moneyChartList().fold<int>(0, (sum, item) => sum + item.money); // 전체 stockCount 합계
    // 리스트의 마지막 10개의 값만 가져오기
    final last10 = list.length > 10 ? list.sublist(list.length - 10) : list;

    // x 값을 0부터 다시 설정
    return last10.asMap().entries.map((entry) {
      final index = entry.key; // 새로운 인덱스
      final spot = entry.value;
      return FlSpot(index.toDouble(), spot.y); // x 값을 0부터 다시 설정
    }).toList();
  }

  // 관리 화면으로 이동하는 함수
  void goSetting() {
    Get.toNamed(AppRoute.settingApp);
  }

  // 차트 데이터 설정 함수
  List<MoneyChartClass> moneyChartList() {
    return [
      MoneyChartClass('현금 자산', myDataController.myMoney.value),
      MoneyChartClass('주식 자산', myDataController.myStockMoney.value)
    ];
  }

  double chartMaxValue() {
    final maxValue = chartSpots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    return ((maxValue / 500000).ceil() * 500000).toDouble();
  }

  String myRank() {
    return '${myDataController.myRank.value != 0 ? myDataController.myRank.value : '-'}';
  }

  // 사용자의 자산 변동률을 계산하는 함수
  RateConfigClass profitRate() {
    double myRate;
    Color myRateColor;
    if (myDataController.totalMoneyHistoryList.length > 1) {
      myRate = (((myDataController.myTotalMoney.value -
                  myDataController
                      .totalMoneyHistoryList[myDataController.totalMoneyHistoryList.length - 2]) /
              myDataController
                  .totalMoneyHistoryList[myDataController.totalMoneyHistoryList.length - 2]) *
          100);
      myRate = double.parse(
        myRate.toStringAsFixed(2),
      );
      if (myRate > -0.01 && myRate < 0.01) {
        myRate = 0.0;
      }
    } else {
      myRate = 0.0;
    }

    if (myRate > 0) {
      myRateColor = Colors.red;
    } else if (myRate < 0) {
      myRateColor = Colors.blue;
    } else {
      myRateColor = Colors.black;
    }
    return RateConfigClass(myRate, myRateColor);
  }

  void nameChangeDialog() {
    final formKey = GlobalKey<FormState>();
    final filter = english_filter.ProfanityFilter(); // 비속어 감지 필터
    bool overlapName = true;
    Get.dialog(
      AlertDialog(
        title: const Text('이름 변경'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Obx(
                  () => Text(
                    '원래 이름 : ${myDataController.myName}',
                    style: TextStyle(
                      fontSize: screenController.screenSize.value.getHeightPerSize(1.6),
                    ),
                  ),
                )),
            SizedBox(
              height: screenController.screenSize.value.getHeightPerSize(1),
            ),
            Form(
              key: formKey,
              child: TextFormField(
                controller: controllerName,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(
                    screenController.screenSize.value.getHeightPerSize(0.5),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                maxLines: 1,
                maxLength: 12,
                onTapOutside: (event) => FocusScope.of(Get.context!).unfocus(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '이름을 입력해주세요';
                  }
                  if (value.containsBadWords || filter.hasProfanity(value)) {
                    return '부적절한 언어 사용은 허용되지 않습니다. 다시 입력해 주세요.';
                  }
                  if (overlapName) {
                    return '이미 사용 중인 이름입니다. 다른 이름을 선택해 주세요.';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              EasyLoading.show(status: '중복 검사중');
              overlapName = await searchName(controllerName.text);
              if (!overlapName && formKey.currentState!.validate()) {
                bool chaekUpdateName = await informationModel.updateName(
                    myDataController.myUid.value,
                    myDataController.myName.value,
                    controllerName.text);
                if (chaekUpdateName) {
                  myDataController.myName.value = controllerName.text;
                  showSimpleSnackbar('변경 완료', '닉네임 변경이 완료되었습니다', SnackPosition.TOP, Colors.black);
                } else {
                  EasyLoading.dismiss();
                  showSimpleSnackbar(
                      '변경 실패', '닉네임 변경에 실패하였습니다\n다시 시도해 주세요', SnackPosition.TOP, Colors.black);
                  logger.e('updateUserName error');
                }
                EasyLoading.dismiss();
              }
            },
            child: const Text('변경'),
          ),
        ],
      ),
    );
  }

  // 팬덤 번경 기능
  void changeFandom(int index) async {
    EasyLoading.show(status: '등록중');
    if (fanNameList[index] != myDataController.myChoicechannel.value) {
      bool checkFandom =
          await informationModel.updateFandom(myDataController.myUid.value, fanNameList[index]);
      EasyLoading.dismiss();
      if (checkFandom) {
        myDataController.myChoicechannel.value = fanNameList[index];
        showSimpleSnackbar('변경 완료', '팬네임 변경이 완료되었습니다', SnackPosition.TOP, Colors.black);
      } else {
        showSimpleSnackbar('변경 실패', '팬네임 변경에 실패하였습니다\n다시 시도해 주세요', SnackPosition.TOP, Colors.black);
      }
    } else {
      EasyLoading.dismiss();
      Get.back();
    }
  }

  // 팬덤 변경 다이어로그 호출
  void changeFandomDialog() {
    Get.dialog(
      FandomChangeDialog(viewModel: this),
    );
  }

  // 로그아웃 기능
  void logout() {
    publicDataController.logOut();
    Get.back();
  }

  // 로그아웃 다이얼로그 호출
  void logoutDialog() {
    Get.dialog(LogoutDialog(viewModel: this));
  }

  Future<void> sendPasswordResetEmail() async {
    final email = myDataController.myId.value;

    if (!email.contains('@') || !email.contains('.') || email.contains('guest')) {
      showSimpleDialog(Get.back, '계정 오류', '현재 사용 중인 계정은 게스트 계정입니다.\n이 기능을 사용하려면 이메일 계정을 생성해 주세요.');
      return;
    }

    EasyLoading.show(status: '이메일 전송 중');
    final bool emailSent = await informationModel.changePW(email);
    EasyLoading.dismiss();

    if (emailSent) {
      Get.dialog(ChangePasswordDialog(email: email, screenSize: screenController.screenSize.value));
    } else {
      showSimpleDialog(Get.back, '오류', '이메일 전송에 실패했습니다.\n다시 시도해 주세요.');
    }
  }
}
