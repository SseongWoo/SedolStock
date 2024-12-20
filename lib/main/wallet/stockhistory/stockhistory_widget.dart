import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:stockpj/main/wallet/stockhistory/stockhistory_system.dart';
import 'package:stockpj/utils/format.dart';
import '../../../data/my_data.dart';
import '../../../utils/date_time.dart';
import '../../../utils/screen_size.dart';

// 거래내역 표1 위젯
class StockHistoryTable1 extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  StockHistoryTable1({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: _screenController.screenSize.value.getHeightPerSize(4),
          width: _screenController.screenSize.value.getWidthPerSize(22),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.1,
                blurRadius: 0.1,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '총 손익금액',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(2),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: _screenController.screenSize.value.getHeightPerSize(4),
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
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  formatToCurrency(_myDataController.totalMoneyHistory.value),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                      color: _myDataController.totalMoneyHistory.value > 0
                          ? Colors.red
                          : _myDataController.totalMoneyHistory.value < 0
                              ? Colors.blue
                              : Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 거래내역 표2 위젯
class StockHistoryTable2 extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  StockHistoryTable2({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: _screenController.screenSize.value.getHeightPerSize(4),
          width: _screenController.screenSize.value.getWidthPerSize(22),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.1,
                blurRadius: 0.1,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '총 판매금액',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(2),
              ),
            ),
          ),
        ),
        Expanded(
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
            child: Padding(
              padding: EdgeInsets.only(
                right: _screenController.screenSize.value.getWidthPerSize(1),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  formatToCurrency(_myDataController.totalSellHistory.value),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _screenController.screenSize.value.getHeightPerSize(4),
          width: _screenController.screenSize.value.getWidthPerSize(22),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.1,
                blurRadius: 0.1,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '총 구매금액',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(2),
              ),
            ),
          ),
        ),
        Expanded(
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
            child: Padding(
              padding: EdgeInsets.only(
                right: _screenController.screenSize.value.getWidthPerSize(1),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  formatToCurrency(_myDataController.totalBuyHistory.value),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 거래내역 목록 위젯
class StockHistoryDataTableWidget extends StatefulWidget {
  const StockHistoryDataTableWidget({super.key});

  @override
  State<StockHistoryDataTableWidget> createState() => _StockHistoryDataTableWidgetState();
}

class _StockHistoryDataTableWidgetState extends State<StockHistoryDataTableWidget> {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final StockHistoryController _stockHistoryController = Get.find<StockHistoryController>();
  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('거래시간\n종목명', _screenController.screenSize.value.getWidthPerSize(30)),
      _getTitleItemWidget('매매구분', _screenController.screenSize.value.getWidthPerSize(25)),
      _getTitleItemWidget('실현손익\n실현수익률', _screenController.screenSize.value.getWidthPerSize(25)),
      _getTitleItemWidget('판매금액\n구매금액', _screenController.screenSize.value.getWidthPerSize(25)),
      _getTitleItemWidget('판매수량\n구매수량', _screenController.screenSize.value.getWidthPerSize(25)),
      _getTitleItemWidget('판매비용\n구매비용', _screenController.screenSize.value.getWidthPerSize(25)),
    ];
  }

  // 데이터 테이블 헤더
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

  // 데이터 테이블 1번째 줄 위젯
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: _screenController.screenSize.value.getWidthPerSize(40),
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
              '${formatDateString2(_myDataController.tradeHistoryList[index].tradetime)}\n${channelMapData[_myDataController.tradeHistoryList[index].itemuid]}(${_myDataController.tradeHistoryList[index].itemtype})')),
    );
  }

  // 데이터 테이블 데이터 위젯
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    bool buy = _myDataController.tradeHistoryList[index].type == 'buy' ? true : false;
    int tradePrice = _myDataController.tradeHistoryList[index].transactionprice *
        _myDataController.tradeHistoryList[index].itemcount;
    int profit = (_myDataController.tradeHistoryList[index].priceavg -
            _myDataController.tradeHistoryList[index].transactionprice) *
        _myDataController.tradeHistoryList[index].itemcount;

    double ratio = (profit /
        (_myDataController.tradeHistoryList[index].priceavg *
            _myDataController.tradeHistoryList[index].itemcount) *
        100);

    Color color = profit > 0
        ? Colors.red
        : profit < 0
            ? Colors.blue
            : Colors.black;

    return Row(
      children: <Widget>[
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            buy ? '구매' : '판매',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '${buy ? '' : formatToCurrency(profit)}\n${buy ? '' : ratio.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: TextStyle(color: color),
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '${buy ? '' : formatToCurrency(tradePrice)}\n${buy ? formatToCurrency(tradePrice) : ''}',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '${buy ? '' : _myDataController.tradeHistoryList[index].itemcount}\n${buy ? _myDataController.tradeHistoryList[index].itemcount : ''}',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: _screenController.screenSize.value.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '${buy ? '' : _myDataController.tradeHistoryList[index].transactionprice}\n${buy ? _myDataController.tradeHistoryList[index].transactionprice : ''}',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: _screenController.screenSize.value.getWidthPerSize(125),
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: _stockHistoryController.historyList.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black38,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        itemExtent: 55,
      ),
    );
  }
}

// 필터 버튼 위젯
class StockHistoryFilterWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  StockHistoryFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenController.screenSize.value.getHeightPerSize(3),
      width: _screenController.screenSize.value.getWidthSize(),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.1),
          bottom: BorderSide(color: Colors.grey, width: 0.1),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: _screenController.screenSize.value.getWidthPerSize(2),
          left: _screenController.screenSize.value.getWidthPerSize(2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Tooltip(
              message: '거래 내역은 최대 100건까지만 표시됩니다.',
              triggerMode: TooltipTriggerMode.tap,
              child: Icon(
                Icons.info_outline,
                size: _screenController.screenSize.value.getHeightPerSize(2),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.tune,
              size: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(StockHistoryBottomSheetWidget());
              },
              child: Text(
                '필터 설정',
                style:
                    TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 필터 설정 바텀시트 위젯
class StockHistoryBottomSheetWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final StockHistoryController _stockHistoryController = Get.find<StockHistoryController>();
  StockHistoryBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _screenController.screenSize.value.getWidthSize(),
      padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(2))
          .copyWith(top: _screenController.screenSize.value.getHeightPerSize(1)),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: _screenController.screenSize.value.getWidthPerSize(5),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              Expanded(
                child: Text(
                  '필터',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2.2),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: _screenController.screenSize.value.getWidthPerSize(5),
              )
            ],
          ),
          const Divider(),
          Text(
            '종목명',
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
          Obx(
            () => Wrap(
              spacing: _screenController.screenSize.value.getWidthPerSize(2),
              runSpacing: 4.0,
              children: _stockHistoryController.itemList.map(
                (filter) {
                  return FilterChip(
                    label: Text(filter),
                    selected: _stockHistoryController.selectedFilters.contains(filter),
                    onSelected: (bool selected) {
                      _stockHistoryController.toggleFilter(filter);
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: _stockHistoryController.selectedFilters.contains(filter)
                          ? Colors.white
                          : Colors.black,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(2),
          ),
          Text(
            '종목유형',
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
          Obx(
            () => Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _stockHistoryController.itemTypeList.map((filter) {
                return ChoiceChip(
                  label: Text(filter),
                  selected: _stockHistoryController.selectItemType.value == filter,
                  onSelected: (bool selected) {
                    _stockHistoryController.selectItemTypeFilter(filter);
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: _stockHistoryController.selectItemType.value == filter
                        ? Colors.white
                        : Colors.black,
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(2),
          ),
          Text(
            '거래유형',
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
          Obx(
            () => Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _stockHistoryController.saleTypeList.map((filter) {
                return ChoiceChip(
                  label: Text(filter),
                  selected: _stockHistoryController.selectSaleType.value == filter,
                  onSelected: (bool selected) {
                    _stockHistoryController.selectSaleTypeFilter(filter);
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: _stockHistoryController.selectSaleType.value == filter
                        ? Colors.white
                        : Colors.black,
                  ),
                );
              }).toList(),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _stockHistoryController.resetFilter();
                  },
                  child: Text(
                    '초기화',
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
                child: SizedBox(
                  height: _screenController.screenSize.value.getHeightPerSize(6),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _stockHistoryController.setfilter();
                      Get.back();
                    },
                    child: Text(
                      '적용하기',
                      style: TextStyle(
                          fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
