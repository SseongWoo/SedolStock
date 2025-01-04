import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../data/youtube_data.dart';
import '../../../utils/color.dart';
import '../../../utils/format.dart';
import 'package:get/get.dart';
import '../../../widget/listview_item.dart';

// 차트 위젯
class TradeDatailPriceChartWidget extends StatelessWidget {
  final ScreenSize screenSize;
  final RxList<FlSpot> chartSpots;
  final RxList<String> chartXTitle;
  final String channelUID;

  const TradeDatailPriceChartWidget({
    super.key,
    required this.screenSize,
    required this.chartSpots,
    required this.chartXTitle,
    required this.channelUID,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenSize.getWidthPerSize(1),
        screenSize.getHeightPerSize(2),
        screenSize.getWidthPerSize(3),
        screenSize.getHeightPerSize(2),
      ),
      child: Obx(
        () => LineChart(
          LineChartData(
            gridData: const FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: screenSize.getWidthPerSize(12),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= chartXTitle.length) return const SizedBox.shrink();
                    return Padding(
                      padding: EdgeInsets.only(top: screenSize.getHeightPerSize(0.5)),
                      child: Text(
                        chartXTitle[value.toInt()],
                        style: TextStyle(fontSize: screenSize.getHeightPerSize(1)),
                      ),
                    );
                  },
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.black, width: 1),
            ),
            minX: 0,
            maxX: chartSpots.isEmpty ? 1 : (chartSpots.length - 1).toDouble(),
            minY: 0,
            maxY: chartSpots.isEmpty
                ? 1
                : (() {
                    final maxValue =
                        chartSpots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
                    int digitCount = maxValue.toInt().toString().length;
                    int baseValue = pow(10, digitCount - 1).toInt();

                    return ((maxValue / baseValue).ceil() * baseValue).toDouble();
                  })(),
            lineBarsData: [
              LineChartBarData(
                spots: chartSpots,
                isCurved: true,
                barWidth: 4,
                color: fanColorMap[channelUID] ?? Colors.blue,
                dotData: const FlDotData(show: true),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipPadding: const EdgeInsets.all(8),
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((spot) {
                    return LineTooltipItem(
                      '${formatToCurrency(spot.y.toInt())} units',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 채널의 최신 10개의 영상을 나타내는 위젯
class TradeDeTailVideoListWidget extends StatelessWidget {
  final ScreenSize screenSize;
  final Function onTapInkWell;
  final Function(int index) onTapIconButton;
  final bool typeMain;
  final List<YoutubeVideoDataClass> videoDataList;

  const TradeDeTailVideoListWidget(
      {super.key,
      required this.screenSize,
      required this.onTapInkWell,
      required this.onTapIconButton,
      required this.typeMain,
      required this.videoDataList});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(
          screenSize.getHeightPerSize(1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${typeMain ? '메인 채널' : '서브 채널'} 최근 업로드된 영상',
                  style: TextStyle(
                    fontSize: screenSize.getHeightPerSize(1.8),
                  ),
                ),
                InkWell(
                  onTap: () => onTapInkWell(),
                  child: Text(
                    typeMain ? '서브' : '메인',
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(1.4),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: videoDataList.length,
                itemBuilder: (context, index) {
                  return buildVideoItem(
                    screenSize,
                    videoDataList[index],
                    index,
                    (index) => onTapIconButton(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
