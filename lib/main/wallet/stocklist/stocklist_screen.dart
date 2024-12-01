import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/wallet/stocklist/stocklist_widget.dart';
import '../../../utils/screen_size.dart';

// 보유 주식 목록 화면
class StocklistScreen extends StatefulWidget {
  const StocklistScreen({super.key});

  @override
  State<StocklistScreen> createState() => _StocklistScreenState();
}

class _StocklistScreenState extends State<StocklistScreen> {
  final ScreenController _screenController = Get.find<ScreenController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StockListCustomTableWidget(),
        const Expanded(
          child: StockDataTableWidget(),
        ),
      ],
    );
  }
}
