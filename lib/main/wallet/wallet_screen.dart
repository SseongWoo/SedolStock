import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/wallet/stockhistory/stockhistory_screen.dart';
import 'package:stockpj/main/wallet/stocklist/stocklist_screen.dart';

import '../../utils/screen_size.dart';

class WalletScreen extends StatelessWidget {
  final ScreenController _screenController = Get.put(ScreenController());
  WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return DefaultTabController(
      length: 2, // 탭의 개수
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: [
              Tab(text: '주식 잔고'),
              Tab(text: '거래 내역'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StocklistScreen(),
            StockHistoryScreen(),
          ],
        ),
      ),
    );
  }
}
