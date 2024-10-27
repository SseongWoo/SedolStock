import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stockpj/main/ranking/ranking_screen.dart';
import 'package:stockpj/main/trade/trade_screen.dart';
import 'package:stockpj/main/wallet/wallet_screen.dart';
import 'home/home_screen.dart';
import 'information/information_screen.dart';

class MainController extends GetxController {
  // 현재 선택된 탭 인덱스
  var selectedIndex = 0.obs;

  // 선택된 탭에 맞는 페이지 가져오기
  final List<Widget> pages = [
    HomeScreen(),
    TradeScreen(),
    RankingScreen(),
    WalletScreen(),
    InformationScreen(),
  ];

  final List<String> pagesName = ['홈', '거래', '랭킹', '지갑', '정보'];

  // 인덱스 변경 함수
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
