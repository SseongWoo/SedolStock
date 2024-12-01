import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/wallet/stockhistory/stockhistory_widget.dart';
import '../../../utils/screen_size.dart';

// 거래 내역 화면
class StockHistoryScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  StockHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StockHistoryTable1(),
        StockHistoryTable2(),
        StockHistoryFilterWidget(),
        const Expanded(child: StockHistoryDataTableWidget()),
      ],
    );
  }
}
