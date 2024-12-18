import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/wallet/stocklist/stocklist_widget.dart';
import '../../../data/my_data.dart';
import '../../../utils/screen_size.dart';

// 보유 주식 목록 화면
class StocklistScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  StocklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StockListMyDataWidget(),
          StockListChartWidget(),
          StockListWidget(),
        ],
      ),
    );
  }
}
