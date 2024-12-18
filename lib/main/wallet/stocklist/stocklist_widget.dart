import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:stockpj/main/wallet/stocklist/stocklist_system.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/format.dart';
import '../../../data/my_data.dart';
import '../../../data/youtube_data.dart';
import '../../../utils/screen_size.dart';

// 주식 목록 표1 위젯
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
                color: Colors.grey,
                spreadRadius: 0.1,
                blurRadius: 0.1,
                offset: Offset(0, 0),
              ),
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

// 주식목록 표2 위젯
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
                color: Colors.grey,
                spreadRadius: 0.1,
                blurRadius: 0.1,
                offset: Offset(0, 0),
              ),
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
                color: Colors.grey,
                spreadRadius: 0.1,
                blurRadius: 0.1,
                offset: Offset(0, 0),
              ),
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

// 보유 주식 목록 위젯
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
      _getTitleItemWidget('종목명\n종목유형', _screenController.screenSize.value.getWidthPerSize(30)),
      _getTitleItemWidget('손익\n수익률', _screenController.screenSize.value.getWidthPerSize(30)),
      _getTitleItemWidget('잔고수량\n평가금액', _screenController.screenSize.value.getWidthPerSize(30)),
      _getTitleItemWidget('매입가\n현재가', _screenController.screenSize.value.getWidthPerSize(30)),
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
    String typeName = _myDataController.stockListItem[index].stockType == 'view' ? '조회수' : '좋아요수';
    return GestureDetector(
      onTap: () {
        _stockListController.goTradeItem(_myDataController.stockListItem[index].stockUID,
            _myDataController.stockListItem[index].stockType);
      },
      child: Container(
        width: _screenController.screenSize.value.getWidthPerSize(30),
        height: 52,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '${_myDataController.stockListItem[index].stockName}\n$typeName',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // 데이터 테이블 데이터 위젯
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _stockListController.goTradeItem(_myDataController.stockListItem[index].stockUID,
            _myDataController.stockListItem[index].stockType);
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
    return Obx(
      () => _myDataController.stockListItem.isNotEmpty
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
            ),
    );
  }
}

// 사용자 자산 테이블 위젯
class StockListCustomTableWidget extends StatelessWidget {
  final MyDataController _myDataController = Get.find<MyDataController>();
  StockListCustomTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
      ),
    );
  }
}

class StockListMyDataWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  StockListMyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: _screenController.screenSize.value.getHeightPerSize(1.5),
          width: _screenController.screenSize.value.getWidthSize(),
          color: colorSUB,
        ),
        SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '가용 자산',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
                      ),
                    ),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(0.5),
                    ),
                    Text(
                      '${formatToCurrency(_myDataController.myMoney.value)} P',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                color: Colors.black, // 선 색상
                thickness: _screenController.screenSize.value.getWidthPerSize(0.3), // 선 두께
                width: _screenController.screenSize.value.getWidthPerSize(0.3),
                indent: _screenController.screenSize.value.getHeightPerSize(1),
                endIndent: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '총 자산',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
                      ),
                    ),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(0.5),
                    ),
                    Text(
                      '${formatToCurrency(_myDataController.myTotalMoney.value)} P',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: _screenController.screenSize.value.getHeightPerSize(0.1),
          width: _screenController.screenSize.value.getWidthSize(),
          color: colorSUB,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            _screenController.screenSize.value.getWidthPerSize(5),
            _screenController.screenSize.value.getHeightPerSize(1),
            _screenController.screenSize.value.getWidthPerSize(5),
            _screenController.screenSize.value.getHeightPerSize(1),
          ),
          child: Column(
            children: [
              MyDataTableWidget(
                title: '현재손익',
                value: '${formatToCurrency(_myDataController.myReturnMoney.value)} P',
              ),
              MyDataTableWidget(
                title: '수익률',
                value: '${_myDataController.myRatioMoney.toStringAsFixed(2)}%',
              ),
              MyDataTableWidget(
                title: '평가금액',
                value: '${formatToCurrency(_myDataController.myStockMoney.value)} P',
              ),
            ],
          ),
        ),
        Container(
          height: _screenController.screenSize.value.getHeightPerSize(1.5),
          width: _screenController.screenSize.value.getWidthSize(),
          color: colorSUB,
        ),
      ],
    );
  }
}

// 내 자산 위젯
class MyDataTableWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final String title;
  final String value;
  MyDataTableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(2),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            color: _myDataController.myReturnMoney.value > 0
                ? Colors.red
                : _myDataController.myReturnMoney.value < 0
                    ? Colors.blue
                    : Colors.black,
          ),
        )
      ],
    );
  }
}

// 파이차트 토글 버튼
class StockListChartWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final StockListController _stockListController = Get.find<StockListController>();
  StockListChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // ExpansionTile(
        //   title: Text('보유 주식 비율 그래프'),
        //   children: [
        //     Container(
        //       height: _screenController.screenSize.value.getHeightPerSize(38),
        //       color: Colors.blue,
        //       child: Center(
        //         child: StockPieChartWidget(),
        //       ),
        //     ),
        //   ],
        // ),
        GestureDetector(
          onTap: _stockListController.toggle,
          child: Obx(
            () => Icon(
              _stockListController.isExpanded.value ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: _screenController.screenSize.value.getHeightPerSize(5),
              color: colorSUB,
            ),
          ),
        ),
        Obx(
          () => AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: SizedBox(
              width: _screenController.screenSize.value.getWidthSize(),
            ), // 숨겨진 상태
            secondChild: SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(38),
              child: StockPieChartWidget(),
            ),
            crossFadeState: _stockListController.isExpanded.value
                ? CrossFadeState.showSecond // 확장된 상태
                : CrossFadeState.showFirst, // 숨겨진 상태
          ),
        ),
      ],
    );
  }
}

// 보유 주식 파이차트
class StockPieChartWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  StockPieChartWidget({super.key});

  List<PieChartSectionData> showingSections() {
    final totalStockCount =
        _myDataController.stockListItem.fold<int>(0, (sum, item) => sum + item.stockCount);

    return _myDataController.stockListItem.map((stock) {
      final double percentage = (stock.stockCount / totalStockCount) * 100;

      return PieChartSectionData(
        value: stock.stockCount.toDouble(),
        color: stock.color,
        title: '${stock.stockCount}(${percentage.toStringAsFixed(1)})%',
        titleStyle: TextStyle(
          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        radius: _screenController.screenSize.value.getHeightPerSize(14),
        badgeWidget: _StockBadge(
          stock.stockType == 'view'
              ? _youtubeDataController.youtubeChannelData[stock.stockUID]!.thumbnail
              : _youtubeDataController
                  .youtubeChannelData[channelAndSubChannelMapData[stock.stockUID]]!.thumbnail,
          size: _screenController.screenSize.value.getWidthPerSize(10),
          borderColor: Colors.black,
        ),
        badgePositionPercentageOffset: .98,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(
            _screenController.screenSize.value.getHeightPerSize(1),
          ),
          child: Text(
            '보유 주식 비율 그래프',
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => _myDataController.stockListItem.isNotEmpty
                ? PieChart(
                    PieChartData(
                      sections: showingSections(),
                      centerSpaceRadius: 0,
                      sectionsSpace: 2,
                    ),
                  )
                : SizedBox(
                    width: _screenController.screenSize.value.getWidthSize(),
                    child: Center(
                      child: Text(
                        '보유한 주식이 없습니다.',
                        style: TextStyle(
                          fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        SizedBox(
          height: _screenController.screenSize.value.getHeightPerSize(3),
        )
      ],
    );
  }
}

class _StockBadge extends StatelessWidget {
  const _StockBadge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Center(
        child: ClipOval(
          child: Image.network(
            svgAsset,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child; // 로딩이 완료되면 이미지 표시
              return const Center(
                child: CircularProgressIndicator(), // 로딩 중인 동안 표시
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Image.asset('assets/image/image_error.png'), // 오류 시 표시할 텍스트
              );
            },
          ),
        ),
      ),
    );
  }
}

class StockListWidget extends StatelessWidget {
  final MyDataController _myDataController = Get.find<MyDataController>();
  StockListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_myDataController.stockListItem.isEmpty) {
        return const Center(child: Text('보유중인 주식이 없습니다.'));
      }

      return SizedBox(
        child: ListView.builder(
          shrinkWrap: true, // 높이를 자식 크기에 맞게 설정
          physics: const NeverScrollableScrollPhysics(), // 스크롤을 부모에게 위임
          itemCount: _myDataController.stockListItem.length,
          itemBuilder: (context, index) {
            return StockListItemWidget(listData: _myDataController.stockListItem[index]);
          },
        ),
      );
    });
  }
}

class StockListItemWidget extends StatefulWidget {
  final StockListClass listData;
  const StockListItemWidget({super.key, required this.listData});

  @override
  State<StockListItemWidget> createState() => _StockListItemWidgetState();
}

class _StockListItemWidgetState extends State<StockListItemWidget> {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final StockListController _stockListController = Get.find<StockListController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  RxBool isExpanded = false.obs;
  late StockListClass listData;
  late String thumbnailData;
  late String channelTitle;
  late Color textColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listData = widget.listData;
    thumbnailData = listData.stockType == 'view'
        ? _youtubeDataController.youtubeChannelData[listData.stockUID]!.thumbnail
        : _youtubeDataController
            .youtubeChannelData[channelAndSubChannelMapData[listData.stockUID]]!.thumbnail;
    channelTitle = listData.stockType == 'view'
        ? _youtubeDataController.youtubeChannelData[listData.stockUID]!.title
        : _youtubeDataController
            .youtubeChannelData[channelAndSubChannelMapData[listData.stockUID]]!.title;
    textColor = listData.stockProfit > 0
        ? Colors.red
        : listData.stockProfit < 0
            ? Colors.blue
            : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            isExpanded.value = !isExpanded.value;
          },
          child: Container(
            height: _screenController.screenSize.value.getHeightPerSize(8),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 1),
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: _screenController.screenSize.value.getWidthPerSize(3),
                right: _screenController.screenSize.value.getWidthPerSize(3),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _stockListController.goTradeItem(listData.stockUID, listData.stockType);
                    },
                    child: SizedBox(
                      width: _screenController.screenSize.value.getHeightPerSize(6),
                      height: _screenController.screenSize.value.getHeightPerSize(6),
                      child: ClipOval(
                        child: Image.network(
                          thumbnailData,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Image.asset('assets/image/image_error.png'),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _screenController.screenSize.value.getHeightPerSize(1),
                  ),
                  SizedBox(
                    width: _screenController.screenSize.value.getWidthPerSize(30),
                    child: Text(
                      channelTitle,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => SizedBox(
                      width: _screenController.screenSize.value.getWidthPerSize(35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          stockListItemParts1(
                              '평가손익 ', '${formatToCurrency(listData.stockProfit)}P', textColor),
                          stockListItemParts1(
                              '수익율 ', '${listData.stockRatio.toStringAsFixed(2)}%', textColor),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: SizedBox(
              width: _screenController.screenSize.value.getWidthSize(),
            ), // 숨겨진 상태
            secondChild: Container(
              height: _screenController.screenSize.value.getHeightPerSize(8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: _screenController.screenSize.value.getWidthPerSize(3),
                  right: _screenController.screenSize.value.getWidthPerSize(3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: _screenController.screenSize.value.getWidthPerSize(35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          stockListItemParts1('보유 잔고', '${listData.stockCount}주', Colors.black),
                          stockListItemParts1(
                              '현재가', '${formatToCurrency(listData.currentPrice)}P', Colors.black),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: _screenController.screenSize.value.getWidthPerSize(35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          stockListItemParts1('매입가',
                              '${formatToCurrency(listData.stockBuyingPrice)}P', Colors.black),
                          stockListItemParts1(
                              '현재가', '${formatToCurrency(listData.currentPrice)}P', Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            crossFadeState: isExpanded.value
                ? CrossFadeState.showSecond // 확장된 상태
                : CrossFadeState.showFirst, // 숨겨진 상태
          ),
        ),
      ],
    );
  }
}

Widget stockListItemParts1(String title, String value, Color textColor) {
  final ScreenController screenController = Get.find<ScreenController>();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: screenController.screenSize.value.getHeightPerSize(1.8),
        ),
      ),
      Expanded(
        child: AutoSizeText(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: screenController.screenSize.value.getHeightPerSize(1.8),
            color: textColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
