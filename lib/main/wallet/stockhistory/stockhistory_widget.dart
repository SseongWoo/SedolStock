import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import '../../../utils/screen_size.dart';

class StockHistoryTable1 extends StatelessWidget {
  final String title;
  final String value;
  const StockHistoryTable1({super.key, required this.title, required this.value});
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
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StockHistoryTable2 extends StatelessWidget {
  final String title1;
  final String value1;
  final String title2;
  final String value2;
  const StockHistoryTable2(
      {super.key,
      required this.title1,
      required this.value1,
      required this.title2,
      required this.value2});
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
            child: Text(
              value1,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(2),
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
            child: Text(
              value2,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final ScreenController _screenController = Get.put(ScreenController());

class StockHistoryDataTableWidget extends StatefulWidget {
  const StockHistoryDataTableWidget({super.key});

  @override
  State<StockHistoryDataTableWidget> createState() => _StockHistoryDataTableWidgetState();
}

class _StockHistoryDataTableWidgetState extends State<StockHistoryDataTableWidget> {
  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('거래시간\n매매구분', _screenController.screenSize.value.getWidthPerSize(25)),
      _getTitleItemWidget('실현손익\n실현수익률', _screenController.screenSize.value.getWidthPerSize(25)),
      _getTitleItemWidget('판매금액\n구매금액', _screenController.screenSize.value.getWidthPerSize(25)),
      _getTitleItemWidget('판매수량\n구매수량', _screenController.screenSize.value.getWidthPerSize(25)),
      _getTitleItemWidget('판매비용\n구매비용', _screenController.screenSize.value.getWidthPerSize(25)),
      _getTitleItemWidget('판매합계\n구매합계', _screenController.screenSize.value.getWidthPerSize(25)),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return InkWell(
      onTap: () => print(index),
      child: Container(
        width: _screenController.screenSize.value.getWidthPerSize(25),
        height: 52,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
        child: FittedBox(fit: BoxFit.scaleDown, child: Text('테스트$index')),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '테스트$index',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '테스트$index',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '테스트$index',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '테스트$index',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '테스트$index',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return HorizontalDataTable(
      leftHandSideColumnWidth: 100,
      rightHandSideColumnWidth: _screenController.screenSize.value.getWidthPerSize(150),
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
      // isFixedFooter: true,
      // footerWidgets: _getTitleWidget(),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: 10,
      rowSeparatorWidget: const Divider(
        color: Colors.black38,
        height: 1.0,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      itemExtent: 55,
    );
  }
}
