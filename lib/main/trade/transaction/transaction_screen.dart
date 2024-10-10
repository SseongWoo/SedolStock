import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/transaction/transaction_ststem.dart';
import 'package:stockpj/main/trade/transaction/transaction_widget.dart';
import 'package:stockpj/utils/timer.dart';
import '../../../utils/screen_size.dart';

class TransactionScreen extends StatefulWidget {
  final bool buying;
  const TransactionScreen({super.key, required this.buying});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final ScreenController _screenController = Get.put(ScreenController());
  final TransactionController _transactionController = Get.put(TransactionController());
  final TextEditingController _controllerNum = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _transactionController.setTransactionText(widget.buying);
  }

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('종목 이름(등락율)'),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_transactionController.transactionText} 가격',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        '100,000,000원',
                        style: TextStyle(
                          fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(1),
            ),
            const CalculatorTitleWidget(),
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
                    const CalculatorRatioButtonWidget(),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    const CalculatorNumButtonWidget(
                      first: 7,
                      second: 8,
                      third: 9,
                    ),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    const CalculatorNumButtonWidget(
                      first: 4,
                      second: 5,
                      third: 6,
                    ),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    const CalculatorNumButtonWidget(
                      first: 1,
                      second: 2,
                      third: 3,
                    ),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    const CalculatorNumButtonWidget(
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
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(6),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _transactionController.transactionText.value == '구매'
                      ? Colors.red
                      : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  '${_transactionController.transactionText} 하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
