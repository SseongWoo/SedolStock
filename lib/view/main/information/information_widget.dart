import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../constants/data_constants.dart';
import '../../../data/public_data.dart';
import '../../../model/main/information_model.dart';
import '../../../utils/color.dart';
import '../../../utils/format.dart';
import '../../../viewmodel/main/information/information_view_model.dart';

// 정보 탭 내 정보 위젯
class InformationMyDataWidget extends StatelessWidget {
  final InformationViewModel viewModel;

  const InformationMyDataWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    RxString choiceChannel = viewModel.myDataController.myChoicechannel;
    return Stack(
      children: [
        Column(
          children: [
            Obx(
              () => Container(
                height: screenSize.getHeightPerSize(8),
                decoration: BoxDecoration(color: fanColorMap[choiceChannel.value]),
              ),
            ),
            Container(
              height: screenSize.getHeightPerSize(11),
              width: screenSize.getWidthSize(),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: screenSize.getHeightPerSize(1),
                ),
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        choiceChannel.value,
                        style: TextStyle(
                            fontSize: screenSize.getHeightPerSize(1.6),
                            color: fanColorMap[choiceChannel.value]),
                      ),
                      Text(
                        viewModel.myDataController.myName.value,
                        style: TextStyle(
                          fontSize: screenSize.getHeightPerSize(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(2),
            ),
            Container(
              height: screenSize.getHeightPerSize(8),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  top: screenSize.getHeightPerSize(0.5),
                  bottom: screenSize.getHeightPerSize(0.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 0.25),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '전일 대비 자산 변동률',
                              style: TextStyle(
                                fontSize: screenSize.getHeightPerSize(1.4),
                              ),
                            ),
                            Obx(
                              () {
                                RateConfigClass rateConfig = viewModel.profitRate();
                                return Text(
                                  '${rateConfig.rate.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    fontSize: screenSize.getHeightPerSize(2),
                                    color: rateConfig.rateColor,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.grey, width: 0.25),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '랭킹',
                              style: TextStyle(
                                fontSize: screenSize.getHeightPerSize(1.4),
                              ),
                            ),
                            Obx(
                              () => Text(
                                viewModel.myRank(),
                                style: TextStyle(
                                  fontSize: screenSize.getHeightPerSize(2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(
                height: screenSize.getHeightPerSize(2),
              ),
              Container(
                height: screenSize.getHeightPerSize(10),
                width: screenSize.getHeightPerSize(10),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
                child: ClipOval(
                  child: Obx(
                    () => Image.asset('assets/image/fan/${fanImageMap[choiceChannel.value]}.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
    List<FlSpot> chartSpots = viewModel.chartSpots;
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
            child: LineChart(
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
                      getTitlesWidget: (value, meta) {
                        final DateTime today = DateTime.now();
                        final DateTime date =
                            today.subtract(Duration(days: (chartSpots.length - 1 - value.toInt())));
                        final String formattedDate = DateFormat('MM/dd').format(date);
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
            ),
          ),
        ),
      ],
    );
  }
}

// 보유 자산 원형 그래프 위젯
class MoneyPieChartWidget extends StatelessWidget {
  final InformationViewModel viewModel;
  const MoneyPieChartWidget({
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
            '보유 자산 비율 그래프',
            style: TextStyle(
              fontSize: screenSize.getHeightPerSize(2),
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            // 반응형 데이터 사용
            List<MoneyChartClass> moneyChartList = viewModel.moneyChartList();
            final totalMoney = moneyChartList.fold<int>(0, (sum, item) => sum + item.money);

            List<PieChartSectionData> sections = moneyChartList.map((money) {
              final double percentage = (money.money / totalMoney) * 100;

              return PieChartSectionData(
                value: money.money.toDouble(),
                color: money.name == '현금 자산'
                    ? fanColorMap[viewModel.myDataController.myChoicechannel.value]
                    : Colors.grey,
                title:
                    '${money.name}\n${formatToCurrency(money.money)}(${percentage.toStringAsFixed(1)})%',
                titleStyle: TextStyle(
                  fontSize: screenSize.getHeightPerSize(1.8),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                radius: screenSize.getHeightPerSize(14),
              );
            }).toList();

            return PieChart(
              PieChartData(
                sections: sections,
                centerSpaceRadius: 0,
                sectionsSpace: 2,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class FandomChangeDialog extends StatelessWidget {
  final InformationViewModel viewModel;
  const FandomChangeDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    RxInt dialogIndex = 0.obs;
    return AlertDialog(
      title: const Text('팬덤 변경'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Obx(() => Text(
                  '기존 팬덤 : ${viewModel.myDataController.myChoicechannel}',
                  style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
                )),
          ),
          SizedBox(height: screenSize.getHeightPerSize(1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (dialogIndex.value <= 0) {
                    dialogIndex.value = fanNameList.length - 1;
                  } else {
                    dialogIndex.value--;
                  }
                },
                icon: Icon(
                  Icons.arrow_left,
                  size: screenSize.getHeightPerSize(5),
                ),
              ),
              Expanded(
                child: Center(
                  child: Obx(() => Text(
                        fanNameList[dialogIndex.value],
                        style: TextStyle(
                          color: fanColorMap[fanNameList[dialogIndex.value]],
                          fontSize: screenSize.getHeightPerSize(3),
                          shadows: const [
                            Shadow(offset: Offset(-1.5, -1.5), color: Colors.black), // 좌상단
                            Shadow(offset: Offset(1.5, -1.5), color: Colors.black), // 우상단
                            Shadow(offset: Offset(1.5, 1.5), color: Colors.black), // 우하단
                            Shadow(offset: Offset(-1.5, 1.5), color: Colors.black), // 좌하단
                          ],
                        ),
                      )),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (dialogIndex.value >= fanNameList.length - 1) {
                    dialogIndex.value = 0;
                  } else {
                    dialogIndex.value++;
                  }
                },
                icon: Icon(
                  Icons.arrow_right,
                  size: screenSize.getHeightPerSize(5),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () => viewModel.changeFandom(dialogIndex.value),
          child: const Text('변경'),
        ),
      ],
    );
  }
}

class LogoutDialog extends StatelessWidget {
  final InformationViewModel viewModel;

  const LogoutDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;

    return AlertDialog(
      title: const Text('로그아웃'),
      content: Text(
        '로그아웃하시겠습니까?',
        style: TextStyle(fontSize: screenSize.getHeightPerSize(1.8)),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: viewModel.logout,
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}

class ChangePasswordDialog extends StatelessWidget {
  final String email;
  final ScreenSize screenSize;

  const ChangePasswordDialog({
    super.key,
    required this.email,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('비밀번호 변경'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '비밀번호 변경 안내 이메일이 아래 주소로 발송되었습니다.',
            style: TextStyle(fontSize: screenSize.getHeightPerSize(1.8)),
          ),
          SizedBox(height: screenSize.getHeightPerSize(1)),
          Text(
            email,
            style: TextStyle(fontSize: screenSize.getHeightPerSize(2)),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('확인'),
        ),
      ],
    );
  }
}
