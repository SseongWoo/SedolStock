import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/trade_widget.dart';
import '../../utils/screen_size.dart';

class TradeScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  TradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return TradeItemListWidget();
  }
}
