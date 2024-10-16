import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/wallet/stockhistory/stockhistory_widget.dart';

import '../../../utils/screen_size.dart';

class StockHistoryScreen extends StatelessWidget {
  final ScreenController _screenController = Get.put(ScreenController());
  StockHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Column(
      children: [
        StockHistoryTable1(
          title: '총손익금액',
          value: '+100,000,000',
        ),
        StockHistoryTable2(
            title1: '총판매금액', value1: '100,000,000', title2: '총구매금액', value2: '100,000,000'),
        Expanded(child: StockHistoryDataTableWidget()),
      ],
    );
  }
}
