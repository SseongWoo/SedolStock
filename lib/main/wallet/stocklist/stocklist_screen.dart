import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/wallet/stocklist/stocklist_widget.dart';

import '../../../utils/screen_size.dart';

class StocklistScreen extends StatefulWidget {
  const StocklistScreen({super.key});

  @override
  State<StocklistScreen> createState() => _StocklistScreenState();
}

class _StocklistScreenState extends State<StocklistScreen> {
  final ScreenController _screenController = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Column(
      children: [
        StockListTable1(
          title: '총자산',
          value: '100,000,000',
        ),
        StockListTable1(
          title: '가용자산',
          value: '100,000,000',
        ),
        StockListTable2(title1: '손익', value1: '100,000,000', title2: '수익률', value2: '1000%'),
        StockListTable1(
          title: '평가금액',
          value: '100,000,000',
        ),
        Expanded(
          child: StockDataTableWidget(),
        ),
      ],
    );
  }
}
