import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/transaction/transaction_system.dart';
import 'package:stockpj/main/trade/transaction/transaction_widget.dart';
import 'package:stockpj/utils/timer.dart';
import '../../../utils/screen_size.dart';

class TransactionScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final TransactionController _transactionController = Get.put(TransactionController());
  TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: TransactionTitleWidget(
          channelUID: _transactionController.channelUID,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: _screenController.screenSize.value.getWidthPerSize(2)),
            child: TimerWidget(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Column(
          children: [
            TransactionPriceWidget(),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(1),
            ),
            CalculatorTitleWidget(),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(1),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
                child: Column(
                  children: [
                    CalculatorRatioButtonWidget(),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    CalculatorNumButtonWidget(
                      first: 7,
                      second: 8,
                      third: 9,
                    ),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    CalculatorNumButtonWidget(
                      first: 4,
                      second: 5,
                      third: 6,
                    ),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    CalculatorNumButtonWidget(
                      first: 1,
                      second: 2,
                      third: 3,
                    ),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    CalculatorNumButtonWidget(
                      first: -2,
                      second: 0,
                      third: -1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(1),
            ),
            TransactionButtonWidget(),
          ],
        ),
      ),
    );
  }
}
