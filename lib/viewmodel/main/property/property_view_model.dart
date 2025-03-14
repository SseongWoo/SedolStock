import 'package:get/get.dart';
import 'package:stockpj/view/main/property/property_history_screen.dart';
import 'package:flutter/material.dart';
import '../../../utils/screen_size.dart';
import '../../../view/main/property/property_stocklist_screen.dart';

// 지갑 뷰 모델
class PropertyViewModel extends GetxController {
  final ScreenController screenController = Get.find<ScreenController>();
  final List<Widget> pages = [
    PropertyStocklistScreen(),
    PropertyHistoryScreen(),
  ];
}
