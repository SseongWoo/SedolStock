import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:korean_profanity_filter/korean_profanity_filter.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:stockpj/main/information/information_system.dart';
import 'package:stockpj/utils/format.dart';
import 'package:stockpj/utils/search_name.dart';
import '../../data/public_data.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';

// 정보 탭 내 정보 위젯
class InformationMyWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final InformationController _informationController = Get.find<InformationController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  InformationMyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Obx(
              () => Container(
                height: _screenController.screenSize.value.getHeightPerSize(8),
                decoration:
                    BoxDecoration(color: fanColorMap[_myDataController.myChoicechannel.value]),
              ),
            ),
            Obx(
              () => Container(
                height: _screenController.screenSize.value.getHeightPerSize(11),
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: _screenController.screenSize.value.getHeightPerSize(1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _myDataController.myChoicechannel.value,
                        style: TextStyle(
                            fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                            color: fanColorMap[_myDataController.myChoicechannel.value]),
                      ),
                      Text(
                        _myDataController.myName.value,
                        style: TextStyle(
                          fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(8),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  top: _screenController.screenSize.value.getHeightPerSize(0.5),
                  bottom: _screenController.screenSize.value.getHeightPerSize(0.5),
                ),
                child: Obx(
                  () => Row(
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
                                  fontSize:
                                      _screenController.screenSize.value.getHeightPerSize(1.4),
                                ),
                              ),
                              Text(
                                '${_informationController.rate.toStringAsFixed(2)}%',
                                style: TextStyle(
                                    fontSize:
                                        _screenController.screenSize.value.getHeightPerSize(2),
                                    color: _informationController.rate.value > 0
                                        ? Colors.red
                                        : _informationController.rate.value < 0
                                            ? Colors.blue
                                            : Colors.black),
                              ),
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
                                  fontSize:
                                      _screenController.screenSize.value.getHeightPerSize(1.4),
                                ),
                              ),
                              Text(
                                '${_myDataController.myRank.value != 0 ? _myDataController.myRank.value : '-'}',
                                style: TextStyle(
                                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
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
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(2),
              ),
              Obx(
                () => Container(
                  height: _screenController.screenSize.value.getHeightPerSize(10),
                  width: _screenController.screenSize.value.getHeightPerSize(10),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
                  child: ClipOval(
                    child: Image.asset(
                        'assets/image/fan/${fanImageMap[_myDataController.myChoicechannel.value]}.png'),
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

// 정보 탭 내 자산 위젯
class InformationPropertyWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  InformationPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            _screenController.screenSize.value.getWidthPerSize(10),
            _screenController.screenSize.value.getHeightPerSize(1),
            _screenController.screenSize.value.getWidthPerSize(10),
            _screenController.screenSize.value.getHeightPerSize(1)),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '내 자산',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
                ),
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              PropertyRowWidget(
                title: '총 자산',
                value: formatToCurrency(_myDataController.myTotalMoney.value),
              ),
              PropertyRowWidget(
                title: '가용 자산',
                value: formatToCurrency(_myDataController.myMoney.value),
              ),
              PropertyRowWidget(
                title: '보유 주식 자산',
                value: formatToCurrency(_myDataController.myStockMoney.value),
              ),
              PropertyRowWidget(
                title: '보유 주식 종목 개수',
                value: '${_myDataController.myStockList.value} 종목',
              ),
              PropertyRowWidget(
                title: '보유 주식 개수',
                value: '${_myDataController.myStockCount.value} 주',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 내 자산 커스텀 위젯
class PropertyRowWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final String title;
  final String value;
  PropertyRowWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
            color: colorISEGYEIDOL,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
            color: colorISEGYEIDOL,
          ),
        ),
      ],
    );
  }
}

// 정보 탭 커스텀 버튼 위젯
class InformationButtonWidget extends StatelessWidget {
  final String title;
  final Function function;
  const InformationButtonWidget({super.key, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          function();
        },
      ),
    );
  }
}

// 정보 탭 대분류 제목 위젯
Widget settingTitle(String title) {
  final ScreenController screenController = Get.find<ScreenController>();
  return Padding(
    padding: EdgeInsets.only(left: screenController.screenSize.value.getWidthPerSize(2)),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenController.screenSize.value.getHeightPerSize(1.8),
        ),
      ),
    ),
  );
}

// 정보 탭 버튼 사이 구분선 위젯
Widget settingDivider() {
  final ScreenController screenController = Get.find<ScreenController>();
  return Divider(
    indent: screenController.screenSize.value.getWidthPerSize(4),
    endIndent: screenController.screenSize.value.getWidthPerSize(4),
    color: Colors.grey, // 경계선 색상
    thickness: 0.5, // 경계선 두께
    height: 0, // 경계선 위아래 여백
  );
}

// 이름 변경 다이얼로그
class NameChangeDialog extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final InformationController _informationController = Get.find<InformationController>();
  NameChangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('이름 변경'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Text(
                  '원래 이름 : ${_myDataController.myName}',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                  ),
                ),
              )),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(1),
          ),
          Form(
            key: _informationController.formKey,
            child: TextFormField(
              controller: _informationController.controllerName,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(
                  _screenController.screenSize.value.getHeightPerSize(0.5),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              maxLines: 1,
              maxLength: 12,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              validator: (value) {
                if (value!.isEmpty) {
                  return '이름을 입력해주세요';
                }
                if (value.containsBadWords || _informationController.filter.hasProfanity(value)) {
                  return '부적절한 언어 사용은 허용되지 않습니다. 다시 입력해 주세요.';
                }
                if (_informationController.overlapName) {
                  return '이미 사용 중인 이름입니다. 다른 이름을 선택해 주세요.';
                }
                return null;
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () async {
            EasyLoading.show(status: '중복 검사중');
            _informationController.overlapName =
                await searchName(_informationController.controllerName.text);
            if (!_informationController.overlapName &&
                _informationController.formKey.currentState!.validate()) {
              await _informationController.updateUserName();
              EasyLoading.dismiss();
            }
          },
          child: const Text('변경'),
        ),
      ],
    );
  }
}

// 팬덤명 변경 다이얼로그
class ChannelChangeDialog extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final InformationController _informationController = Get.find<InformationController>();
  ChannelChangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('팬덤 변경'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Text(
                  '기존 팬덤 : ${_myDataController.myChoicechannel}',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                  ),
                ),
              )),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (_informationController.dialogIndex.value <= 0) {
                    _informationController.dialogIndex.value = fanNameList.length - 1;
                  } else {
                    _informationController.dialogIndex.value--;
                  }
                },
                icon: Icon(
                  Icons.arrow_left,
                  size: _screenController.screenSize.value.getHeightPerSize(5),
                ),
              ),
              Expanded(
                child: Center(
                    child: Obx(
                  () => Text(
                    fanNameList[_informationController.dialogIndex.value],
                    style: TextStyle(
                      color: fanColorMap[fanNameList[_informationController.dialogIndex.value]],
                      fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                      shadows: const [
                        Shadow(offset: Offset(-1.5, -1.5), color: Colors.black), // 좌상단
                        Shadow(offset: Offset(1.5, -1.5), color: Colors.black), // 우상단
                        Shadow(offset: Offset(1.5, 1.5), color: Colors.black), // 우하단
                        Shadow(offset: Offset(-1.5, 1.5), color: Colors.black), // 좌하단
                      ],
                    ),
                  ),
                )),
              ),
              IconButton(
                onPressed: () {
                  if (_informationController.dialogIndex.value >= fanNameList.length - 1) {
                    _informationController.dialogIndex.value = 0;
                  } else {
                    _informationController.dialogIndex.value++;
                  }
                },
                icon: Icon(
                  Icons.arrow_right,
                  size: _screenController.screenSize.value.getHeightPerSize(5),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () async {
            EasyLoading.show(status: '등록중');
            if (fanNameList[_informationController.dialogIndex.value] !=
                _myDataController.myChoicechannel.value) {
              await _informationController.updateFanName();
            } else {
              EasyLoading.dismiss();
              Get.back();
            }
          },
          child: const Text('변경'),
        ),
      ],
    );
  }
}

// 로그아웃 다이얼로그
class LogoutDialog extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('로그아웃'),
      content: Text(
        '로그아웃하시겠습니까?',
        style: TextStyle(
          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            _publicDataController.logOut();
          },
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}

// 비밀번호 변경 다이얼로그
class ChangePWDialog extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  ChangePWDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('비밀번호 변경'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '비밀번호 변경 안내 이메일이 아래 주소로 발송되었습니다.',
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
            ),
          ),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(1),
          ),
          Text(
            _myDataController.myId.string,
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('확인'),
        ),
      ],
    );
  }
}

// 보유 자산 비율 그래프 위젯
class ChartLine extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final InformationController _informationController = Get.find<InformationController>();
  ChartLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
          child: Text(
            '보유 자산 변동 그래프',
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              _screenController.screenSize.value.getWidthPerSize(2),
              _screenController.screenSize.value.getHeightPerSize(1),
              _screenController.screenSize.value.getWidthPerSize(6),
              _screenController.screenSize.value.getHeightPerSize(1),
            ),
            child: Obx(
              () => LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    // y축 설정
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: _screenController.screenSize.value.getWidthPerSize(12),
                      ),
                    ),
                    // x축 설정
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final DateTime today = DateTime.now();
                          final DateTime date = today.subtract(Duration(
                              days:
                                  (_informationController.chartSpots.length - 1 - value.toInt())));
                          final String formattedDate = DateFormat('MM/dd').format(date);
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                  fontSize:
                                      _screenController.screenSize.value.getHeightPerSize(1.2)),
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
                  maxX: _informationController.chartSpots.isEmpty
                      ? 1
                      : (_informationController.chartSpots.length - 1).toDouble(),
                  minY: 0,
                  maxY: _informationController.chartSpots.isEmpty
                      ? 1
                      : (() {
                          final maxValue = _informationController.chartSpots
                              .map((spot) => spot.y)
                              .reduce((a, b) => a > b ? a : b);
                          return ((maxValue / 500000).ceil() * 500000).toDouble();
                        })(),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _informationController.chartSpots,
                      isCurved: true,
                      barWidth: 4,
                      color: fanColorMap[_myDataController.myChoicechannel.value],
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
        ),
      ],
    );
  }
}

// 보유 주식 원형 그래프 위젯
class StockPieChartWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  StockPieChartWidget({super.key});

  List<PieChartSectionData> showingSections() {
    final totalStockCount = _myDataController.stockListItem
        .fold<int>(0, (sum, item) => sum + item.stockCount); // 전체 stockCount 합계

    return _myDataController.stockListItem.map((stock) {
      final double percentage = (stock.stockCount / totalStockCount) * 100;

      return PieChartSectionData(
        value: stock.stockCount.toDouble(), // stockCount 값을 사용
        color: stock.color, // StockListClass.color를 색상으로 사용
        title: '${stock.stockCount}(${percentage.toStringAsFixed(1)})%',
        // title:
        //     '${stock.stockName}(${stock.stockType == 'view' ? '조' : '좋'})\n${stock.stockCount}(${percentage.toStringAsFixed(1)})%',
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
          padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
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

// 보유 자산 원형 그래프 위젯
class MoneyPieChartWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final InformationController _informationController = Get.find<InformationController>();
  MoneyPieChartWidget({super.key});

  List<PieChartSectionData> showingSections() {
    final totalMoney = _informationController.moneyChartList
        .fold<int>(0, (sum, item) => sum + item.money); // 전체 stockCount 합계

    return _informationController.moneyChartList.map((money) {
      final double percentage = (money.money / totalMoney) * 100;

      return PieChartSectionData(
        value: money.money.toDouble(), // stockCount 값을 사용
        color: money.name == '현금 자산'
            ? fanColorMap[_myDataController.myChoicechannel.value]
            : Colors.grey, // StockListClass.color를 색상으로 사용
        title:
            '${money.name}\n${formatToCurrency(money.money)}(${percentage.toStringAsFixed(1)})%', // 이름 + 퍼센트
        titleStyle: TextStyle(
          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        radius: _screenController.screenSize.value.getHeightPerSize(14),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
          child: Text(
            '보유 자산 비율 그래프',
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => PieChart(
              PieChartData(
                sections: showingSections(),
                centerSpaceRadius: 0,
                sectionsSpace: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
