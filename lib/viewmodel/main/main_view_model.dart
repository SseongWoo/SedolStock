import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/view/main/home/home_screen.dart';
import 'package:stockpj/view/main/property/property_screen.dart';
import 'package:stockpj/view/main/ranking/ranking_screen.dart';
import 'package:stockpj/view/main/trade/trade_screen.dart';
import '../../constants/route_constants.dart';
import '../../data/my_data.dart';
import '../../utils/screen_size.dart';
import '../../view/main/information/information_screen.dart';

// 메인화면 뷰모델
class MainViewModel extends GetxController {
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  // 현재 선택된 탭 인덱스
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    int? index = Get.arguments;
    if (index != null) {
      selectedIndex.value = index;
    }
  }

  void onPressed() {
    Get.toNamed(
      AppRoute.notification,
    );
  }

  // 인덱스 변경 함수
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

// 각각의 탭 이름
  final List<String> pagesName = ['홈', '거래', '랭킹', '지갑', '정보'];

  // 선택된 탭에 맞는 페이지 가져오기
  final List<Widget> pages = [
    HomeScreen(),
    TradeScreen(),
    RankingScreen(),
    PropertyScreen(),
    InformationScreen(),
  ];

  int counvertKeyId(int keyId){
    switch(keyId){
      case 49 : return 0;
      case 50 : return 1;
      case 51 : return 2;
      case 52 : return 3;
      case 53 : return 4;
      default: return 0;
    }
  }
}
