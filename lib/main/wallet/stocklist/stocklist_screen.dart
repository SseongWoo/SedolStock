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
  final ScreenController _screenController = Get.find<ScreenController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StockListCustomTableWidget(),
        Expanded(
          child: StockDataTableWidget(),
        ),
      ],
    );
  }
}
