import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/trade_widget.dart';
import '../../utils/screen_size.dart';

// 거래 화면
class TradeScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  TradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: _screenController.screenSize.value.getHeightPerSize(3),
          actions: [TradeSelectWidget()],
        ),
        body: TradeItemListWidget());
  }
}
