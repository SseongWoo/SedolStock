import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/format.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/view/main/trade/trade_detail_widget.dart';
import '../../../utils/timer.dart';
import '../../../viewmodel/main/trade/trade_detail_view_model.dart';

// 주식 아이템 상세정보 화면
class TradeDetailScreen extends StatelessWidget {
  final TradeDetailViewModel _viewModel = Get.put(TradeDetailViewModel());
  TradeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.screenController.updateScreenSize(context);
    });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () {
            return Opacity(
              opacity: _viewModel.opacity.value,
              child: Column(
                children: [
                  Text(
                    '${_viewModel.youtubeDataController.channelMapData[_viewModel.channelUID]!} (${_viewModel.type == 'view' ? '조회수' : '좋아요수'})',
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(1.6),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formatToCurrency(_viewModel.itemPriceData.value.price),
                        style: TextStyle(
                          fontSize: screenSize.getHeightPerSize(1.6),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.getWidthPerSize(2),
                      ),
                      Text(
                        '${_viewModel.itemPriceData.value.differencePrice > 0 ? '+' : ''}${formatToCurrency(_viewModel.itemPriceData.value.differencePrice)} (${_viewModel.itemPriceData.value.ratio.toStringAsFixed(2)}%)',
                        style: TextStyle(
                          fontSize: screenSize.getHeightPerSize(1.6),
                          color: profitAndLossColor(_viewModel.itemPriceData.value.differencePrice),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenSize.getWidthPerSize(2)),
            child: TimerWidget(),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _viewModel.scrollController,
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenSize.getWidthPerSize(2), right: screenSize.getWidthPerSize(2)),
                child: Column(
                  children: [
                    Container(
                      height: screenSize.getHeightPerSize(70),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.1,
                            blurRadius: 0.1,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(
                            screenSize.getHeightPerSize(1),
                          ),
                          child: Obx(
                            () {
                              final chartData = _viewModel.tradeDetailChartData.value;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _viewModel.tradeDetailChartData.value.title,
                                    style: TextStyle(
                                      fontSize: screenSize.getHeightPerSize(2.4),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        chartData.price,
                                        style: TextStyle(
                                          fontSize: screenSize.getHeightPerSize(3),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenSize.getWidthPerSize(2),
                                      ),
                                      Text(
                                        chartData.returnRatio,
                                        style: TextStyle(
                                          fontSize: screenSize.getHeightPerSize(2.2),
                                          color: profitAndLossColor(
                                              _viewModel.itemPriceData.value.differencePrice),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: TradeDatailPriceChartWidget(
                                      screenSize: screenSize,
                                      chartSpots: _viewModel.chartSpots,
                                      chartXTitle: _viewModel.chartXTitle,
                                      channelUID: _viewModel.channelUID,
                                    ),
                                  ),
                                  _chartDetailData(
                                    screenSize,
                                    '총 ${_viewModel.typeLabel}',
                                    formatToCurrency(_viewModel.itemPriceData.value.totalCount),
                                    1.6,
                                  ),
                                  _chartDetailData(
                                    screenSize,
                                    '서브채널 총 ${_viewModel.typeLabel}',
                                    formatToCurrency(_viewModel.itemPriceData.value.subTotalCount),
                                    1.6,
                                  ),
                                  _chartDetailData(
                                    screenSize,
                                    '이전 총 ${_viewModel.typeLabel}',
                                    formatToCurrency(
                                        _viewModel.itemPriceData.value.beforeTotalCount),
                                    1.6,
                                  ),
                                  _chartDetailData(
                                    screenSize,
                                    '서브채널 이전 총 ${_viewModel.typeLabel}',
                                    formatToCurrency(
                                        _viewModel.itemPriceData.value.subBeforeTotalCount),
                                    1.6,
                                  ),
                                ],
                              );
                            },
                          )),
                    ),
                    SizedBox(
                      height: screenSize.getHeightPerSize(1),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.1,
                            blurRadius: 0.1,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          screenSize.getHeightPerSize(1),
                        ),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '보유 주식',
                                style: TextStyle(
                                  fontSize: screenSize.getHeightPerSize(3),
                                ),
                              ),
                              _chartDetailData(
                                screenSize,
                                '1주 평균 구매 금액',
                                _viewModel.myStockDataClass.value.holdAvgPrice,
                                1.8,
                              ),
                              _chartDetailData(
                                screenSize,
                                '보유 수량',
                                '${_viewModel.myStockDataClass.value.holdCount}주',
                                1.8,
                              ),
                              ListTile(
                                title: Text(
                                  '총 금액',
                                  style: TextStyle(
                                    fontSize: screenSize.getHeightPerSize(1.8),
                                  ),
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${formatToCurrency(_viewModel.myStockDataClass.value.holdTotalPrice)}원',
                                      style: TextStyle(
                                        fontSize: screenSize.getHeightPerSize(1.8),
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    AutoSizeText(
                                      _viewModel.myStockDataClass.value.holdReturnRatio,
                                      style: TextStyle(
                                          fontSize: screenSize.getHeightPerSize(1.8),
                                          color: profitAndLossColor(_viewModel.profit.value)),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.getHeightPerSize(1),
                    ),
                    TradeDeTailVideoListWidget(
                      screenSize: screenSize,
                      onTapInkWell: _viewModel.onTapVideoListInkWell,
                      onTapIconButton: _viewModel.onTapVideListIconButton,
                      typeMain: _viewModel.typeMain.value,
                      videoDataList: _viewModel.getVideoListData(),
                    ),
                    SizedBox(
                      height: screenSize.getHeightPerSize(8),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: screenSize.getHeightPerSize(1),
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenSize.getWidthPerSize(4), right: screenSize.getWidthPerSize(4)),
                child: _viewModel.delistingState()
                    ? _saleButton(
                        screenSize,
                        _viewModel.delistingTitle(),
                        Colors.grey,
                        () {},
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _saleButton(
                              screenSize,
                              '판매하기',
                              Colors.blue,
                              () => _viewModel.goTransaction(false),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.getWidthPerSize(4),
                          ),
                          Expanded(
                            child: _saleButton(
                              screenSize,
                              '구매하기',
                              Colors.red,
                              () => _viewModel.goTransaction(true),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 상세 정보 커스텀 위젯
  Widget _chartDetailData(ScreenSize screenSize, String title, String trailing, double fontSize) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: screenSize.getHeightPerSize(fontSize),
        ),
      ),
      trailing: Text(
        trailing,
        style: TextStyle(
          fontSize: screenSize.getHeightPerSize(fontSize),
        ),
      ),
    );
  }

  Widget _saleButton(ScreenSize screenSize, String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      height: screenSize.getHeightPerSize(6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 원하는 둥글기 정도 설정
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: screenSize.getHeightPerSize(2), color: Colors.white),
        ),
      ),
    );
  }
}
