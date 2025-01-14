import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:get/get.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/format.dart';
import '../../../viewmodel/main/property/property_stocklist_view_model.dart';

class PropertyStockListItemWidget extends StatelessWidget {
  final PropertyStocklistViewModel viewModel;
  final StockListClass stockData;

  const PropertyStockListItemWidget({
    super.key,
    required this.viewModel,
    required this.stockData,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = viewModel.screenController.screenSize.value;

    return Column(
      children: [
        GestureDetector(
          onTap: () => viewModel.toggleItemExpansion(stockData.stockUID),
          child: _buildStockOverview(screenSize),
        ),
        _buildStockDetails(screenSize),
        //Obx(() => _buildStockDetails(screenSize)),
      ],
    );
  }

  Widget _buildStockOverview(ScreenSize screenSize) {
    return Container(
      height: screenSize.getHeightPerSize(8),
      decoration: const BoxDecoration(
        border: Border(
          //top: BorderSide(color: Colors.grey, width: 1),
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.getWidthPerSize(3)),
        child: Row(
          children: [
            _buildThumbnail(screenSize),
            SizedBox(width: screenSize.getHeightPerSize(1)),
            _buildChannelTitle(screenSize),
            const Spacer(),
            _buildStockSummary(screenSize),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail(ScreenSize screenSize) {
    return GestureDetector(
      onTap: () => viewModel.goTradeItem(stockData.stockUID),
      child: SizedBox(
        width: screenSize.getHeightPerSize(6),
        height: screenSize.getHeightPerSize(6),
        child: ClipOval(
          child: Image.network(
            viewModel.youtubeDataController.youtubeChannelData[stockData.stockUID]!.thumbnail,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Image.asset('assets/image/image_error.png'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChannelTitle(ScreenSize screenSize) {
    return GestureDetector(
      onTap: () => viewModel.goTradeItem(stockData.stockUID),
      child: SizedBox(
        width: screenSize.getWidthPerSize(30),
        child: Text(
          viewModel.youtubeDataController.youtubeChannelData[stockData.stockUID]!.title,
          softWrap: true,
          style: TextStyle(
            fontSize: screenSize.getHeightPerSize(1.8),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStockSummary(ScreenSize screenSize) {
    return SizedBox(
      width: screenSize.getWidthPerSize(35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStockDetailRow(
            title: '평가손익',
            value: '${formatToCurrency(stockData.stockProfit)}P',
            color: profitAndLossColor(stockData.stockProfit),
            screenSize: screenSize,
          ),
          _buildStockDetailRow(
            title: '수익률',
            value: '${stockData.stockRatio.toStringAsFixed(2)}%',
            color: profitAndLossColor(stockData.stockProfit),
            screenSize: screenSize,
          ),
        ],
      ),
    );
  }

  Widget _buildStockDetails(ScreenSize screenSize) {
    return Container(
      height: screenSize.getHeightPerSize(8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.getWidthPerSize(3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStockDetailColumn(
              screenSize: screenSize,
              title1: '보유 잔고',
              value1: '${stockData.stockCount}주',
              title2: '평가 금액',
              value2: '${formatToCurrency(stockData.stockTotalPrice)}P',
              color: Colors.black,
            ),
            _buildStockDetailColumn(
              screenSize: screenSize,
              title1: '매입가',
              value1: '${formatToCurrency(stockData.stockBuyingPrice)}P',
              title2: '현재가',
              value2: '${formatToCurrency(stockData.currentPrice)}P',
              color: profitAndLossColor(stockData.stockProfit),
            ),
          ],
        ),
      ),
    );
    //   AnimatedCrossFade(
    //   duration: const Duration(milliseconds: 100),
    //   firstChild: SizedBox(
    //     width: screenSize.getWidthSize(),
    //   ),
    //   secondChild: Container(
    //     height: screenSize.getHeightPerSize(8),
    //     decoration: const BoxDecoration(
    //       border: Border(
    //         bottom: BorderSide(color: Colors.grey, width: 1),
    //       ),
    //     ),
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: screenSize.getWidthPerSize(3)),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           _buildStockDetailColumn(
    //             screenSize: screenSize,
    //             title1: '보유 잔고',
    //             value1: viewModel.getStockCount(stockData),
    //             title2: '현재가',
    //             value2: viewModel.getFormattedCurrentPrice(stockData),
    //           ),
    //           _buildStockDetailColumn(
    //             screenSize: screenSize,
    //             title1: '매입가',
    //             value1: viewModel.getFormattedBuyingPrice(stockData),
    //             title2: '현재가',
    //             value2: viewModel.getFormattedCurrentPrice(stockData),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   crossFadeState: viewModel.isItemExpanded(stockData.stockUID)
    //       ? CrossFadeState.showSecond
    //       : CrossFadeState.showFirst,
    // );
  }

  Widget _buildStockDetailRow({
    required String title,
    required String value,
    required Color color,
    required ScreenSize screenSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: screenSize.getHeightPerSize(1.8)),
        ),
        Expanded(
          child: AutoSizeText(
            value,
            textAlign: TextAlign.right,
            maxLines: 1,
            style: TextStyle(
              fontSize: screenSize.getHeightPerSize(1.8),
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStockDetailColumn({
    required ScreenSize screenSize,
    required String title1,
    required String value1,
    required String title2,
    required String value2,
    required Color color,
  }) {
    return SizedBox(
      width: screenSize.getWidthPerSize(35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStockDetailRow(
            title: title1,
            value: value1,
            color: Colors.black,
            screenSize: screenSize,
          ),
          _buildStockDetailRow(
            title: title2,
            value: value2,
            color: color,
            screenSize: screenSize,
          ),
        ],
      ),
    );
  }
}

// 주식 보유 비율 파이차트
class PropertyStockPieChartWidget extends StatelessWidget {
  final PropertyStocklistViewModel viewModel;

  const PropertyStockPieChartWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    // screenSize를 상단에서 한 번만 선언
    final screenSize = viewModel.screenController.screenSize.value;
    final hasStocks = viewModel.myDataController.stockListItem.isNotEmpty;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
          child: Text(
            '보유 주식 비율 그래프',
            style: TextStyle(
              fontSize: screenSize.getHeightPerSize(2),
            ),
          ),
        ),
        Expanded(
          child: hasStocks
              ? PieChart(
                  PieChartData(
                    sections: _buildPieChartSections(screenSize), // 전달된 screenSize를 사용
                    centerSpaceRadius: 0,
                    sectionsSpace: 2,
                  ),
                )
              : Center(
                  child: Text(
                    '보유한 주식이 없습니다.',
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(1.6),
                    ),
                  ),
                ),
        ),
        SizedBox(height: screenSize.getHeightPerSize(3)),
      ],
    );
  }

  // 파이차트 섹션 데이터 생성
  List<PieChartSectionData> _buildPieChartSections(ScreenSize screenSize) {
    final stockDataList = viewModel.myDataController.stockListItem.values.toList();

    final totalStockCount = stockDataList.fold<int>(0, (sum, item) => sum + item.stockCount);

    if (totalStockCount == 0) return [];

    return stockDataList.map((stock) {
      final double percentage = (stock.stockCount / totalStockCount) * 100;

      return PieChartSectionData(
        value: stock.stockCount.toDouble(),
        color: stock.color,
        title: '${stock.stockCount} (${percentage.toStringAsFixed(1)}%)',
        titleStyle: TextStyle(
          fontSize: screenSize.getHeightPerSize(1.8),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        radius: screenSize.getHeightPerSize(14),
        badgeWidget: _buildBadge(screenSize, stock), // 전달된 screenSize를 사용
        badgePositionPercentageOffset: .98,
      );
    }).toList();
  }

  // 배지 생성
  Widget _buildBadge(ScreenSize screenSize, StockListClass stock) {
    final String thumbnail =
        viewModel.youtubeDataController.youtubeChannelData[stock.stockUID]!.thumbnail;

    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: screenSize.getWidthPerSize(10),
      height: screenSize.getWidthPerSize(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          thumbnail,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Image.asset('assets/image/image_error.png'),
            );
          },
        ),
      ),
    );
  }
}
