import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/main/trade/transaction/transaction_ststem.dart';
import '../../../data/youtube_data.dart';
import '../../../utils/format.dart';
import '../../../utils/screen_size.dart';

class TransactionTitleWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final TransactionController _transactionController = Get.find<TransactionController>();
  final String channelUID;
  TransactionTitleWidget({super.key, required this.channelUID});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(channelMapData[channelUID]!),
        Text(
          ' (${_transactionController.stockRatio.toStringAsFixed(2)}%)',
          style: TextStyle(color: _transactionController.textColor),
        ),
      ],
    );
  }
}

class TransactionPriceWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final TransactionController _transactionController = Get.find<TransactionController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  TransactionPriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
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
              title: Obx(
                () => Text(
                  '${formatToCurrency(_transactionController.calculatorSum.value)}원',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  ),
                ),
              ),
              subtitle: Text(
                '현재 가격 : ${formatToCurrency(_youtubeDataController.youtubeLiveData[_transactionController.channelUID]!.viewCountPrice)}원',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorTitleWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final TransactionController _transactionController = Get.find<TransactionController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  CalculatorTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              '내 잔고 : ${formatToCurrency(_myDataController.myMoney.value)}원',
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
  final ScreenController _screenController = Get.find<ScreenController>();
  final TransactionController _transactionController = Get.find<TransactionController>();
  final int num;
  CalculatorNumWidget({super.key, required this.num});

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
  final ScreenController _screenController = Get.find<ScreenController>();
  final TransactionController _transactionController = Get.find<TransactionController>();
  CalculatorRatioButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              _transactionController.onTapHalf();
            },
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
            onPressed: () {
              _transactionController.onTapMax();
            },
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
  final ScreenController _screenController = Get.find<ScreenController>();
  final int first;
  final int second;
  final int third;
  CalculatorNumButtonWidget(
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

class TransactionButtonWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final TransactionController _transactionController = Get.find<TransactionController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  TransactionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _screenController.screenSize.value.getHeightPerSize(6),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _transactionController.buying ? Colors.red : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          transactionDialog(
              _transactionController.buying,
              channelMapData[_transactionController.channelUID]!,
              _transactionController.calculatorInt.value,
              _youtubeDataController
                  .youtubeLiveData[_transactionController.channelUID]!.viewCountPrice);
        },
        child: Text(
          '${_transactionController.transactionText} 하기',
          style: TextStyle(
            color: Colors.white,
            fontSize: _screenController.screenSize.value.getHeightPerSize(2),
          ),
        ),
      ),
    );
  }
}

void transactionDialog(
  bool buying,
  String title,
  int transactionCount,
  int price,
) {
  final TransactionController transactionController = Get.find<TransactionController>();
  final ScreenController screenController = Get.find<ScreenController>();
  String buyingText = buying ? '구매' : '판매';
  Get.dialog(
    Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(screenController.screenSize.value.getWidthPerSize(4), 0,
            screenController.screenSize.value.getWidthPerSize(4), 0),
        child: Container(
          width: screenController.screenSize.value.getWidthPerSize(92),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: screenController.screenSize.value.getHeightPerSize(2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min, // Dialog 크기를 내용에 맞게 조절
              children: [
                Text(
                  '$buyingText 주문 확인',
                  style: TextStyle(
                      fontSize: screenController.screenSize.value.getHeightPerSize(2),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenController.screenSize.value.getHeightPerSize(2)),
                transactionTableWidget('종목명', title),
                transactionTableWidget('거래유형', buying ? '구매' : '판매'),
                transactionTableWidget('$buyingText수량', '$transactionCount주'),
                transactionTableWidget('$buyingText단가', '${formatToCurrency(price)}원'),
                transactionTableWidget(
                    '총$buyingText가격', '${formatToCurrency(price * transactionCount)}원'),
                SizedBox(height: screenController.screenSize.value.getHeightPerSize(2)),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: screenController.screenSize.value.getHeightPerSize(6),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20), // 왼쪽 아래만 둥글게
                                  bottomRight: Radius.circular(0), // 나머지 부분은 둥글지 않게
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                ),
                              ),
                              backgroundColor: Colors.grey),
                          onPressed: () {
                            Get.back(); // 다이얼로그 닫기
                          },
                          child: Text(
                            '취소',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenController.screenSize.value.getHeightPerSize(2)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: screenController.screenSize.value.getHeightPerSize(6),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0), // 왼쪽 아래만 둥글게
                                  bottomRight: Radius.circular(20), // 나머지 부분은 둥글지 않게
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                ),
                              ),
                              backgroundColor: buying ? Colors.red : Colors.blue),
                          onPressed: () {
                            Get.back();
                            transactionController.trySale(price, transactionCount);
                          },
                          child: Text(
                            buyingText,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenController.screenSize.value.getHeightPerSize(2)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget transactionTableWidget(String title, String content) {
  final ScreenController _screenController = Get.find<ScreenController>();
  return Padding(
    padding: EdgeInsets.fromLTRB(_screenController.screenSize.value.getWidthPerSize(2), 0,
        _screenController.screenSize.value.getWidthPerSize(2), 0),
    child: SizedBox(
      //height: _screenController.screenSize.value.getHeightPerSize(6),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: _screenController.screenSize.value.getHeightPerSize(4),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
                ],
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ' $title',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: _screenController.screenSize.value.getHeightPerSize(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.1,
                    blurRadius: 0.1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ' $content',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
