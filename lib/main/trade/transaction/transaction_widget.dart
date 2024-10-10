import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/transaction/transaction_ststem.dart';
import '../../../utils/screen_size.dart';

final ScreenController _screenController = Get.put(ScreenController());
final TransactionController _transactionController = Get.put(TransactionController());

class CalculatorTitleWidget extends StatelessWidget {
  const CalculatorTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: _screenController.screenSize.value.getHeightPerSize(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            _screenController.screenSize.value.getHeightPerSize(1),
            _screenController.screenSize.value.getHeightPerSize(1),
            0,
            _screenController.screenSize.value.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '주식 ${_transactionController.transactionText} 수량',
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
              ),
            ),
            ListTile(
              title: Obx(
                () => Text(_transactionController.calculatorDisplay.value),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      _transactionController.onTapMinus();
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  IconButton(
                    onPressed: () {
                      _transactionController.onTapPlus();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Text(
              '내 잔고 : 100,000,000 원',
              style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.5),
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorNumWidget extends StatelessWidget {
  final int num;
  const CalculatorNumWidget({super.key, required this.num});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _screenController.screenSize.value.getHeightPerSize(8),
      width: _screenController.screenSize.value.getWidthPerSize(26),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide.none,
          ),
        ),
        onPressed: () {
          _transactionController.onTapNumButton(num);
        },
        child: num == -1
            ? const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )
            : Text(
                num >= 0 ? num.toString() : 'AC',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                ),
              ),
      ),
    );
  }
}

class CalculatorRatioButtonWidget extends StatelessWidget {
  const CalculatorRatioButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {},
            child: Text(
              '절반',
              style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  color: Colors.black),
            ),
          ),
        ),
        SizedBox(
          width: _screenController.screenSize.value.getWidthPerSize(4),
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {},
            child: Text(
              '최대',
              style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}

class CalculatorNumButtonWidget extends StatelessWidget {
  final int first;
  final int second;
  final int third;
  const CalculatorNumButtonWidget(
      {super.key, required this.first, required this.second, required this.third});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorNumWidget(
          num: first,
        ),
        SizedBox(
          width: _screenController.screenSize.value.getWidthPerSize(4),
        ),
        CalculatorNumWidget(
          num: second,
        ),
        SizedBox(
          width: _screenController.screenSize.value.getWidthPerSize(4),
        ),
        CalculatorNumWidget(
          num: third,
        ),
      ],
    );
  }
}
