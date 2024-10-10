import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'detail/trade_detail_screen.dart';

class TradeController extends GetxController {
  void goTradeItem() {
    Get.to(() => const TradeDetailScreen());
  }
}
