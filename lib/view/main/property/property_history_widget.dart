import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/date_time.dart';
import '../../../utils/format.dart';
import '../../../viewmodel/main/property/property_history_view_model.dart';

// 필터 설정 바텀시트 위젯
class PropertyHistoryBottomSheet extends StatelessWidget {
  final PropertyHistoryViewModel viewModel;
  const PropertyHistoryBottomSheet({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    return Container(
      width: screenSize.getWidthSize(),
      padding: EdgeInsets.all(screenSize.getHeightPerSize(2))
          .copyWith(top: screenSize.getHeightPerSize(1)),
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
                width: screenSize.getWidthPerSize(5),
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
                    fontSize: screenSize.getHeightPerSize(2.2),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: screenSize.getWidthPerSize(5),
              )
            ],
          ),
          const Divider(),
          Obx(
            () => _buildFilterSection(
              screenSize: screenSize,
              title: '종목명',
              itemList: viewModel.itemList,
              selectedItems: viewModel.selectedFilters,
              onSelected: viewModel.toggleFilter,
              isFilterChip: true,
            ),
          ),
          SizedBox(height: screenSize.getHeightPerSize(2)),
          Obx(
            () => _buildFilterSection(
              screenSize: screenSize,
              title: '종목유형',
              itemList: viewModel.itemTypeList,
              selectedItems: [viewModel.selectItemType.value],
              onSelected: (filter) => viewModel.selectItemTypeFilter(filter),
            ),
          ),
          SizedBox(height: screenSize.getHeightPerSize(2)),
          Obx(
            () => _buildFilterSection(
              screenSize: screenSize,
              title: '거래유형',
              itemList: viewModel.saleTypeList,
              selectedItems: [viewModel.selectSaleType.value],
              onSelected: (filter) => viewModel.selectSaleTypeFilter(filter),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                height: screenSize.getHeightPerSize(6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    viewModel.resetFilter();
                  },
                  child: Text(
                    '초기화',
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(2), color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: screenSize.getWidthPerSize(4),
              ),
              Expanded(
                child: SizedBox(
                  height: screenSize.getHeightPerSize(6),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      viewModel.setfilter();
                      Get.back();
                    },
                    child: Text(
                      '적용하기',
                      style:
                          TextStyle(fontSize: screenSize.getHeightPerSize(2), color: Colors.white),
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

  // 필터 섹션 UI
  Widget _buildFilterSection({
    required ScreenSize screenSize,
    required String title,
    required List<String> itemList,
    required List<String> selectedItems,
    required Function(String) onSelected,
    bool isFilterChip = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText(screenSize, title),
        Wrap(
          spacing: screenSize.getWidthPerSize(2),
          runSpacing: 4.0,
          children: itemList.map((filter) {
            return isFilterChip
                ? FilterChip(
                    label: Text(filter),
                    selected: selectedItems.contains(filter),
                    onSelected: (bool selected) => onSelected(filter),
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: screenSize.getHeightPerSize(1.6),
                      color: selectedItems.contains(filter) ? Colors.white : Colors.black,
                    ),
                  )
                : ChoiceChip(
                    label: Text(filter),
                    selected: selectedItems.contains(filter),
                    onSelected: (bool selected) => onSelected(filter),
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: screenSize.getHeightPerSize(1.6),
                      color: selectedItems.contains(filter) ? Colors.white : Colors.black,
                    ),
                  );
          }).toList(),
        ),
      ],
    );
  }

  // 제목 텍스트 UI
  Widget _buildTitleText(ScreenSize screenSize, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: screenSize.getHeightPerSize(2),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// 거래내역 목록 위젯
class PropertyHistoryDataTableWidget extends StatefulWidget {
  final PropertyHistoryViewModel viewModel;
  const PropertyHistoryDataTableWidget({super.key, required this.viewModel});

  @override
  State<PropertyHistoryDataTableWidget> createState() => _StockHistoryDataTableWidgetState();
}

class _StockHistoryDataTableWidgetState extends State<PropertyHistoryDataTableWidget> {
  late PropertyHistoryViewModel viewModel;
  late ScreenSize screenSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = widget.viewModel;
    screenSize = viewModel.screenController.screenSize.value;
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('거래시간\n종목명', screenSize.getWidthPerSize(30)),
      _getTitleItemWidget('매매구분', screenSize.getWidthPerSize(25)),
      _getTitleItemWidget('실현손익\n실현수익률', screenSize.getWidthPerSize(25)),
      _getTitleItemWidget('판매금액\n구매금액', screenSize.getWidthPerSize(25)),
      _getTitleItemWidget('판매수량\n구매수량', screenSize.getWidthPerSize(25)),
      _getTitleItemWidget('판매수수료\n구매수수료', screenSize.getWidthPerSize(25)),
      _getTitleItemWidget('판매합계\n구매합계', screenSize.getWidthPerSize(25)),
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
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenSize.getHeightPerSize(1.6)),
        textAlign: TextAlign.center,
      ),
    );
  }

  // 데이터 테이블 1번째 줄 위젯
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    TradeHistoryClass tradeHistoryData = viewModel.historyList[index];
    return Container(
      width: screenSize.getWidthPerSize(40),
      height: 52,
      padding: EdgeInsets.fromLTRB(screenSize.getWidthPerSize(2), 0, 0, 0),
      alignment: Alignment.center,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatDateString2(tradeHistoryData.tradetime),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
            ),
            Text(
              viewModel.youtubeDataController.youtubeChannelData[tradeHistoryData.itemuid]?.title ??
                  '채널명',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
            ),
          ],
        ),
      ),
    );
  }

  // 데이터 테이블 데이터 위젯
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    TradeHistoryClass tradeHistoryData = viewModel.historyList[index];
    bool buy = tradeHistoryData.tradetype == 'buy' ? true : false;

    return Row(
      children: <Widget>[
        Container(
          width: screenSize.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            buy ? '구매' : '판매',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
          ),
        ),
        Container(
          width: screenSize.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: buy ? null : viewModel.getProfitReturnWidget(tradeHistoryData),
        ),
        Container(
          width: screenSize.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '${buy ? '' : formatToCurrency(tradeHistoryData.tradeprice)}\n${buy ? formatToCurrency(tradeHistoryData.tradeprice) : ''}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
          ),
        ),
        Container(
          width: screenSize.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '${buy ? '' : tradeHistoryData.itemcount}\n${buy ? tradeHistoryData.itemcount : ''}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
          ),
        ),
        Container(
          width: screenSize.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '${buy ? '' : formatToCurrency(tradeHistoryData.fee)}\n${buy ? formatToCurrency(tradeHistoryData.fee) : ''}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
          ),
        ),
        Container(
          width: screenSize.getWidthPerSize(25),
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
            '${buy ? '' : formatToCurrency(tradeHistoryData.totalcost)}\n${buy ? formatToCurrency(tradeHistoryData.totalcost) : ''}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
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
        rightHandSideColumnWidth: screenSize.getWidthPerSize(150),
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: viewModel.historyList.length,
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
