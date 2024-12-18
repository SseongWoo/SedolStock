import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stockpj/main/trade/detail/trade_detail_system.dart';
import 'package:stockpj/utils/date_time.dart';
import 'package:stockpj/utils/format.dart';
import 'package:stockpj/utils/simple_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/my_data.dart';
import '../../../data/youtube_data.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';
import 'dart:math';

// 앱바의 타이틀 부분 위젯 변수
class TradeDetailAppBarTitleWidget extends StatelessWidget {
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final TradeDetailController _tradeDetailController = Get.find<TradeDetailController>();
  final ScreenController _screenController = Get.find<ScreenController>();
  TradeDetailAppBarTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${channelMapData[_tradeDetailController.channelUID]!} (${_tradeDetailController.type == 'view' ? '조회수' : '좋아요수'})',
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatToCurrency(_tradeDetailController.type == 'view'
                    ? _youtubeDataController
                        .youtubeLiveData[_tradeDetailController.channelUID]!.viewCountPrice
                    : _youtubeDataController
                        .youtubeLiveData[_tradeDetailController.channelUID]!.likeCountPrice),
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                ),
              ),
              SizedBox(
                width: _screenController.screenSize.value.getWidthPerSize(2),
              ),
              Text(
                '${_tradeDetailController.stockReturn > 0 ? '+${_tradeDetailController.stockReturn}' : _tradeDetailController.stockReturn} (${_tradeDetailController.stockRatio.toStringAsFixed(2)}%)',
                style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                    color: _tradeDetailController.titleTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 상세 정보 커스텀 위젯
class TradeDetailListTileWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final String title;
  final String trailing;
  final double fontSize;
  TradeDetailListTileWidget(
      {super.key, required this.title, required this.trailing, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: _screenController.screenSize.value.getHeightPerSize(fontSize),
        ),
      ),
      trailing: Text(
        trailing,
        style: TextStyle(
          fontSize: _screenController.screenSize.value.getHeightPerSize(fontSize),
        ),
      ),
    );
  }
}

// 상세 정보 가격 그래프 위젯
class TradeDatailChartWidget extends StatelessWidget {
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final TradeDetailController _tradeDetailController = Get.find<TradeDetailController>();
  final ScreenController _screenController = Get.find<ScreenController>();
  TradeDatailChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenController.screenSize.value.getHeightPerSize(70),
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
          _screenController.screenSize.value.getHeightPerSize(1),
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${channelMapData[_tradeDetailController.channelUID]!} (${_tradeDetailController.type == 'view' ? '조회수' : '좋아요수'})',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2.4),
                ),
              ),
              Row(
                children: [
                  Text(
                    formatToCurrency(_tradeDetailController.type == 'view'
                        ? _youtubeDataController
                            .youtubeLiveData[_tradeDetailController.channelUID]!.viewCountPrice
                        : _youtubeDataController
                            .youtubeLiveData[_tradeDetailController.channelUID]!.likeCountPrice),
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                    ),
                  ),
                  SizedBox(
                    width: _screenController.screenSize.value.getWidthPerSize(2),
                  ),
                  Text(
                    '${_tradeDetailController.stockReturn > 0 ? '+${_tradeDetailController.stockReturn}' : _tradeDetailController.stockReturn} (${_tradeDetailController.stockRatio > 0 ? '+' : ''}${_tradeDetailController.stockRatio.toStringAsFixed(2)}%)',
                    style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(2.2),
                        color: _tradeDetailController.titleTextColor),
                  ),
                ],
              ),
              Expanded(
                child: TradeDatailLineChartWidget(),
              ),
              TradeDetailListTileWidget(
                title: _tradeDetailController.type == 'view' ? '총 조회수' : '총 좋아요수',
                trailing: _tradeDetailController.type == 'view'
                    ? formatToCurrency(_youtubeDataController
                        .youtubeLiveData[_tradeDetailController.channelUID]!.totalViewCount)
                    : formatToCurrency(_youtubeDataController
                        .youtubeLiveData[_tradeDetailController.channelUID]!.totalLikeCount),
                fontSize: 1.6,
              ),
              TradeDetailListTileWidget(
                title: _tradeDetailController.type == 'view' ? '서브 채널 총 조회수' : '서브 채널 총 좋아요수',
                trailing: _tradeDetailController.type == 'view'
                    ? formatToCurrency(_youtubeDataController
                        .youtubeLiveData[
                            channelAndSubChannelMapData[_tradeDetailController.channelUID]]!
                        .totalViewCount)
                    : formatToCurrency(_youtubeDataController
                        .youtubeLiveData[
                            channelAndSubChannelMapData[_tradeDetailController.channelUID]]!
                        .totalLikeCount),
                fontSize: 1.6,
              ),
              TradeDetailListTileWidget(
                title: _tradeDetailController.type == 'view' ? '이전 총 조회수' : '이전 총 좋아요수',
                trailing: _tradeDetailController.type == 'view'
                    ? formatToCurrency(_youtubeDataController
                        .youtubeLiveData[_tradeDetailController.channelUID]!.lastTotalViewCount)
                    : formatToCurrency(_youtubeDataController
                        .youtubeLiveData[_tradeDetailController.channelUID]!.lastTotalLikeCount),
                fontSize: 1.6,
              ),
              TradeDetailListTileWidget(
                title: _tradeDetailController.type == 'view' ? '서브 채널 이전 총 조회수' : '서브 채널 이전 총 좋아요수',
                trailing: _tradeDetailController.type == 'view'
                    ? formatToCurrency(_youtubeDataController
                        .youtubeLiveData[
                            channelAndSubChannelMapData[_tradeDetailController.channelUID]]!
                        .lastTotalViewCount)
                    : formatToCurrency(_youtubeDataController
                        .youtubeLiveData[
                            channelAndSubChannelMapData[_tradeDetailController.channelUID]]!
                        .lastTotalLikeCount),
                fontSize: 1.6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 차트 위젯
class TradeDatailLineChartWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final TradeDetailController _tradeDetailController = Get.find<TradeDetailController>();
  TradeDatailLineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          _screenController.screenSize.value.getWidthPerSize(1),
          _screenController.screenSize.value.getHeightPerSize(2),
          _screenController.screenSize.value.getWidthPerSize(3),
          _screenController.screenSize.value.getHeightPerSize(2)),
      child: Obx(
        () {
          return LineChart(
            LineChartData(
              gridData: const FlGridData(show: true),
              titlesData: FlTitlesData(
                // Y축 설정
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: _screenController.screenSize.value.getWidthPerSize(12),
                  ),
                ),
                // X축 설정
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: _screenController.screenSize.value.getHeightPerSize(0.5)),
                        child: Text(
                          _tradeDetailController.chartXTitle[value.toInt()],
                          style: TextStyle(
                              fontSize: _screenController.screenSize.value.getHeightPerSize(1)),
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
              maxX: _tradeDetailController.chartSpots.isEmpty
                  ? 1
                  : (_tradeDetailController.chartSpots.length - 1).toDouble(),
              minY: 0,
              maxY: _tradeDetailController.chartSpots.isEmpty
                  ? 1
                  : (() {
                      final maxValue = _tradeDetailController.chartSpots
                          .map((spot) => spot.y)
                          .reduce((a, b) => a > b ? a : b);
                      int digitCount = maxValue.toInt().toString().length;
                      int baseValue = pow(10, digitCount - 1).toInt();

                      return ((maxValue / baseValue).ceil() * baseValue).toDouble();
                    })(),
              lineBarsData: [
                LineChartBarData(
                  spots: _tradeDetailController.chartSpots,
                  isCurved: true,
                  barWidth: 4,
                  color: fanColorMap[_tradeDetailController.channelUID] ?? Colors.blue,
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
          );
        },
      ),
    );
  }
}

// 사용자의 자산 정보 위젯
class TradeDetailMyStock extends StatelessWidget {
  final TradeDetailController _tradeDetailController = Get.find<TradeDetailController>();
  final ScreenController _screenController = Get.find<ScreenController>();
  TradeDetailMyStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _screenController.screenSize.value.getHeightPerSize(1),
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '보유 주식',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                ),
              ),
              TradeDetailListTileWidget(
                title: '1주 평균 금액',
                trailing: '${formatToCurrency(_tradeDetailController.walletAvg.value)}원',
                fontSize: 1.8,
              ),
              TradeDetailListTileWidget(
                title: '보유 수량',
                trailing: '${_tradeDetailController.walletCount}',
                fontSize: 1.8,
              ),
              ListTile(
                title: Text(
                  '총 금액',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                  ),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${formatToCurrency(_tradeDetailController.walletSum.value)}원',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    AutoSizeText(
                      '${formatToCurrency(_tradeDetailController.walletReturn.value)}(${_tradeDetailController.walletRatio.value.toStringAsFixed(2)}%)',
                      style: TextStyle(
                          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                          color: _tradeDetailController.walletReturn.value > 0
                              ? Colors.red
                              : _tradeDetailController.walletReturn.value < 0
                                  ? Colors.blue
                                  : Colors.black),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 상세정보 구매 판매 버튼 위젯
class TradeDetailButtonWidget extends StatelessWidget {
  final TradeDetailController _tradeDetailController = Get.find<TradeDetailController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final ScreenController _screenController = Get.find<ScreenController>();
  TradeDetailButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: _screenController.screenSize.value.getWidthPerSize(4),
          right: _screenController.screenSize.value.getWidthPerSize(4)),
      child: (_tradeDetailController.type == 'view'
                  ? _youtubeDataController
                      .youtubeLiveData[_tradeDetailController.channelUID]!.viewDelisting
                  : _youtubeDataController
                      .youtubeLiveData[_tradeDetailController.channelUID]!.likeDelisting) >
              0
          ? SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // 원하는 둥글기 정도 설정
                  ),
                ),
                onPressed: () {},
                child: Text(
                  '상장 폐지중(${_tradeDetailController.type == 'view' ? _youtubeDataController.youtubeLiveData[_tradeDetailController.channelUID]!.viewDelisting : _youtubeDataController.youtubeLiveData[_tradeDetailController.channelUID]!.likeDelisting})',
                  style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                      color: Colors.white),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: _screenController.screenSize.value.getHeightPerSize(6),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // 원하는 둥글기 정도 설정
                        ),
                      ),
                      onPressed: () {
                        _tradeDetailController.goTransaction(false);
                      },
                      child: Text(
                        '판매하기',
                        style: TextStyle(
                            fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                            color: Colors.white),
                      ),
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
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // 원하는 둥글기 정도 설정
                        ),
                      ),
                      onPressed: () {
                        _tradeDetailController.goTransaction(true);
                      },
                      child: Text(
                        '구매하기',
                        style: TextStyle(
                            fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// 채널의 최신 10개의 영상을 나타내는 위젯
class DetailVideoListWidget extends StatelessWidget {
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final TradeDetailController _tradeDetailController = Get.find<TradeDetailController>();
  final ScreenController _screenController = Get.find<ScreenController>();
  DetailVideoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(
          _screenController.screenSize.value.getHeightPerSize(1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    '${_tradeDetailController.typeMain.value ? '메인 채널' : '서브 채널'} 최근 업로드된 영상',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _tradeDetailController.typeMain.value = !_tradeDetailController.typeMain.value;
                  },
                  child: Obx(
                    () => Text(
                      _tradeDetailController.typeMain.value ? '서브' : '메인',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(100),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _youtubeDataController
                      .youtubeVideoData[_tradeDetailController.typeMain.value
                          ? _tradeDetailController.channelUID
                          : channelAndSubChannelMapData[_tradeDetailController.channelUID]]
                      ?.length,
                  itemBuilder: (context, index) {
                    final videoData = _youtubeDataController.youtubeVideoData[
                        _tradeDetailController.typeMain.value
                            ? _tradeDetailController.channelUID
                            : channelAndSubChannelMapData[_tradeDetailController.channelUID]];
                    if (videoData == null || videoData.isEmpty) {
                      return const Center(
                        child: Text('영상 데이터를 불러올 수 없습니다.'),
                      );
                    }
                    return SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(10),
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(
                            height: _screenController.screenSize.value.getHeightPerSize(8),
                            width: _screenController.screenSize.value.getWidthPerSize(30),
                            child: Image.network(
                              videoData[index].thumbnailurl,
                              fit: BoxFit.cover, // 이미지가 부모 컨테이너에 맞도록
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child; // 로딩이 완료되면 이미지 표시
                                return const Center(
                                  child: CircularProgressIndicator(), // 로딩 중 표시
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child:
                                      Image.asset('assets/image/image_error.png'), // 오류 시 표시할 텍스트
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: _screenController.screenSize.value.getWidthPerSize(2),
                          ),
                          SizedBox(
                            width: _screenController.screenSize.value.getWidthPerSize(48),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  videoData[index].title,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize:
                                        _screenController.screenSize.value.getHeightPerSize(1.8),
                                  ),
                                ),
                                Text(
                                  formatDateString(videoData[index].publishedat),
                                  style: TextStyle(
                                    fontSize:
                                        _screenController.screenSize.value.getHeightPerSize(1.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () async {
                                final Uri url = Uri.parse(
                                  'https://www.youtube.com/watch?v=${videoData[index].videoid}',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  showSimpleSnackbar('오류', '오류가 발생했습니다. 네트워크 연결을 확인하거나, 다시 시도해주세요.',
                                      SnackPosition.TOP, Colors.red);
                                }
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
