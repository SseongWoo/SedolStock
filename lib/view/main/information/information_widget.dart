import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../utils/color.dart';
import '../../../utils/format.dart';
import '../../../viewmodel/main/information/information_view_model.dart';

// 보유 자산 비율 그래프 위젯
class MyMoneyChartLine extends StatelessWidget {
  final InformationViewModel viewModel;

  const MyMoneyChartLine({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
          child: Text(
            '보유 자산 변동 그래프',
            style: TextStyle(
              fontSize: screenSize.getHeightPerSize(2),
            ),
          ),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                screenSize.getWidthPerSize(2),
                screenSize.getHeightPerSize(1),
                screenSize.getWidthPerSize(6),
                screenSize.getHeightPerSize(1),
              ),
              child: Obx(
                () {
                  final chartSpots = viewModel.chartSpots;
                  return LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: FlTitlesData(
                        // y축 설정
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: screenSize.getWidthPerSize(12),
                          ),
                        ),
                        // x축 설정
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              final int index = value.toInt();
                              final int length =
                                  viewModel.myDataController.totalMoneyHistoryList.length;

                              // 인덱스가 범위를 벗어나지 않도록 체크
                              if (index < 0 || index >= length) {
                                return const SizedBox.shrink();
                              }

                              // 처음, 중간, 끝 인덱스만 보여주기
                              if (index != 0 && index != length ~/ 2 && index != length - 1) {
                                return const SizedBox.shrink();
                              }

                              // 해당 인덱스의 날짜 가져오기
                              final String dateStr =
                                  viewModel.myDataController.totalMoneyHistoryList[index].date;

                              // 날짜 형식 보정
                              final DateTime parsedDate = DateFormat('yyyy-M-d').parse(dateStr);
                              final String formattedDate = DateFormat('MM/dd').format(parsedDate);

                              // 반환
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  formattedDate,
                                  style: TextStyle(fontSize: screenSize.getHeightPerSize(1.2)),
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
                      maxY: chartSpots.isEmpty ? 1 : viewModel.chartMaxValue(),
                      lineBarsData: [
                        LineChartBarData(
                          spots: chartSpots,
                          isCurved: true,
                          barWidth: 4,
                          color: fanColorMap[viewModel.myDataController.myChoicechannel.value],
                          dotData: const FlDotData(show: true),
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          tooltipPadding: const EdgeInsets.all(8),
                          getTooltipItems: (List<LineBarSpot> touchedSpots) {
                            return touchedSpots.map((spot) {
                              return LineTooltipItem(
                                '${formatToCurrency(spot.y.toInt())} units', // 단위 추가
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
                  );
                },
              )),
        ),
      ],
    );
  }
}
