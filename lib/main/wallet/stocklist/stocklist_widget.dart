import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import '../../../utils/screen_size.dart';

final ScreenController _screenController = Get.put(ScreenController());

class StockListTable1 extends StatelessWidget {
  final String title;
  final String value;
  const StockListTable1({super.key, required this.title, required this.value});
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

class StockListTable2 extends StatelessWidget {
  final String title1;
  final String value1;
  final String title2;
  final String value2;
  const StockListTable2(
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

class StockDataTableWidget extends StatefulWidget {
  const StockDataTableWidget({super.key});

  @override
  State<StockDataTableWidget> createState() => _StockDataTableWidgetState();
}

class _StockDataTableWidgetState extends State<StockDataTableWidget> {
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
    return InkWell(
      onTap: () => print(index),
      child: Container(
        width: _screenController.screenSize.value.getWidthPerSize(30),
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
          width: _screenController.screenSize.value.getWidthPerSize(30),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '$index 손익\n$index 수익률',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(30),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '$index 수량\n평가금액',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(30),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '$index 매입가\n현재가',
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
      rightHandSideColumnWidth: _screenController.screenSize.value.getWidthPerSize(90),
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
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
