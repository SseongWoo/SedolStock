import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:stockpj/main/wallet/stocklist/stocklist_system.dart';
import 'package:stockpj/utils/format.dart';
import '../../../data/my_data.dart';
import '../../../utils/screen_size.dart';

class StockListTable1 extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final String title;
  final String value;
  StockListTable1({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(20),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
            ],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
              ],
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(right: _screenController.screenSize.value.getWidthPerSize(1)),
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StockListTable2 extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final String title1;
  final String value1;
  final String title2;
  final String value2;
  final Color color;
  StockListTable2(
      {super.key,
      required this.title1,
      required this.value1,
      required this.title2,
      required this.value2,
      required this.color});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(20),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
            ],
          ),
          child: Text(
            title1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
              ],
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(right: _screenController.screenSize.value.getWidthPerSize(1)),
              child: Text(
                value1,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  color: color,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(20),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
            ],
          ),
          child: Text(
            title2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
              ],
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(right: _screenController.screenSize.value.getWidthPerSize(1)),
              child: Text(
                value2,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StockDataTableWidget extends StatefulWidget {
  const StockDataTableWidget({super.key});

  @override
  State<StockDataTableWidget> createState() => _StockDataTableWidgetState();
}

class _StockDataTableWidgetState extends State<StockDataTableWidget> {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final StockListController _stockListController = Get.find<StockListController>();
  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('종목명', _screenController.screenSize.value.getWidthPerSize(30)),
      _getTitleItemWidget('손익\n수익률', _screenController.screenSize.value.getWidthPerSize(30)),
      _getTitleItemWidget('잔고수량\n평가금액', _screenController.screenSize.value.getWidthPerSize(30)),
      _getTitleItemWidget('매입가\n현재가', _screenController.screenSize.value.getWidthPerSize(30)),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _stockListController.goTradeItem(_myDataController.stockListItem[index].stockUID);
      },
      child: Container(
        width: _screenController.screenSize.value.getWidthPerSize(30),
        height: 52,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
        child: FittedBox(
            fit: BoxFit.scaleDown, child: Text(_myDataController.stockListItem[index].stockName)),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _stockListController.goTradeItem(_myDataController.stockListItem[index].stockUID);
      },
      child: Row(
        children: <Widget>[
          Container(
            width: _screenController.screenSize.value.getWidthPerSize(30),
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
            child: Text(
              '${formatToCurrency(_myDataController.stockListItem[index].stockProfit)}\n${_myDataController.stockListItem[index].stockRatio.toStringAsFixed(2)}%',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _myDataController.stockListItem[index].stockProfit > 0
                      ? Colors.red
                      : _myDataController.stockListItem[index].stockProfit < 0
                          ? Colors.blue
                          : Colors.black),
            ),
          ),
          Container(
            width: _screenController.screenSize.value.getWidthPerSize(30),
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
            child: Text(
              '${_myDataController.stockListItem[index].stockCount}\n${formatToCurrency(_myDataController.stockListItem[index].stockTotalPrice)}',
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: _screenController.screenSize.value.getWidthPerSize(30),
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatToCurrency(_myDataController.stockListItem[index].stockBuyingPrice),
                  textAlign: TextAlign.center,
                ),
                Text(
                  formatToCurrency(_myDataController.stockListItem[index].currentPrice),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _myDataController.stockListItem[index].stockBuyingPrice <
                            _myDataController.stockListItem[index].currentPrice
                        ? Colors.red
                        : _myDataController.stockListItem[index].stockBuyingPrice >
                                _myDataController.stockListItem[index].currentPrice
                            ? Colors.blue
                            : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _myDataController.stockListItem.isNotEmpty
        ? HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: _screenController.screenSize.value.getWidthPerSize(90),
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(),
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: _myDataController.stockListItem.length,
            rowSeparatorWidget: const Divider(
              color: Colors.black38,
              height: 1.0,
              thickness: 0.0,
            ),
            leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
            rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
            itemExtent: 55,
          )
        : const Center(
            child: Text('보유한 주식이 없습니다.'),
          );
  }
}

class StockListCustomTableWidget extends StatelessWidget {
  final MyDataController _myDataController = Get.find<MyDataController>();

  StockListCustomTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StockListTable1(
          title: '총자산',
          value: formatToCurrency(_myDataController.myTotalMoney.value),
        ),
        StockListTable1(
          title: '가용자산',
          value: formatToCurrency(_myDataController.myMoney.value),
        ),
        StockListTable2(
          title1: '손익',
          value1: formatToCurrency(_myDataController.myReturnMoney.value),
          title2: '수익률',
          value2: '${_myDataController.myRatioMoney.toStringAsFixed(2)}%',
          color: _myDataController.myReturnMoney.value > 0
              ? Colors.red
              : _myDataController.myReturnMoney.value < 0
                  ? Colors.blue
                  : Colors.black,
        ),
        StockListTable1(
          title: '평가금액',
          value: _myDataController.myStockMoney.string,
        ),
      ],
    );
  }
}
