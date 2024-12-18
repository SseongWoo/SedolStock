import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/wallet/stockhistory/stockhistory_screen.dart';
import 'package:stockpj/main/wallet/stocklist/stocklist_screen.dart';
import 'package:stockpj/utils/color.dart';
import '../../utils/screen_size.dart';

// 지갑 화면
class WalletScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 탭의 개수
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: TabBar(
            labelColor: colorMAIN,
            unselectedLabelColor: colorSUB,
            dividerColor: Colors.white,
            indicator: BoxDecoration(
              color: colorSUB,
              borderRadius: BorderRadius.circular(15),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(
                child: Text(
                  '주식 잔고',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  '거래 내역',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
