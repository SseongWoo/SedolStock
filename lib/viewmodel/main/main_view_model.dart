import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/view/main/home/home_screen.dart';
import 'package:stockpj/view/main/property/property_screen.dart';
import 'package:stockpj/view/main/ranking/ranking_screen.dart';
import 'package:stockpj/view/main/trade/trade_screen.dart';

import '../../constants/route_constants.dart';
import '../../view/main/information/information_screen.dart';

class MainViewModel extends GetxController {
  // 현재 선택된 탭 인덱스
  RxInt selectedIndex = 0.obs;

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
}
