import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stockpj/main/trade/detail/trade_detail_system.dart';
import 'package:stockpj/utils/date_time.dart';
import 'package:stockpj/utils/format.dart';
import 'package:stockpj/utils/simple_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/youtube_data.dart';
import '../../../utils/screen_size.dart';

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
class TradeDatailChartWidget extends StatefulWidget {
  const TradeDatailChartWidget({super.key});

  @override
  State<TradeDatailChartWidget> createState() => _TradeDatailChartWidgetState();
}

class _TradeDatailChartWidgetState extends State<TradeDatailChartWidget> {
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final TradeDetailController _tradeDetailController = Get.find<TradeDetailController>();
  final ScreenController _screenController = Get.find<ScreenController>();
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

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
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(
                    autoScrollingDelta: 5, // X축에서 5개의 데이터만 보여주고 나머지는 스크롤 가능
                    autoScrollingMode: AutoScrollingMode.end, // 끝부분에서 스크롤
                  ),
                  primaryYAxis: NumericAxis(
                    numberFormat: NumberFormat.decimalPattern(),
                    //minimum: _tradeDetailController.minYValue.value,
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true, // 팬(슬라이드) 기능 활성화
                  ),
                  series: <LineSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                      dataSource: _tradeDetailController.type == 'view'
                          ? _youtubeDataController
                              .youtubeChartData[_tradeDetailController.channelUID]
                              ?.viewCount
                              .reversed
                              .toList()
                          : _youtubeDataController
                              .youtubeChartData[_tradeDetailController.channelUID]
                              ?.likeCount
                              .reversed
                              .toList(),
                      xValueMapper: (SalesData sales, _) => sales.time,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      markerSettings: MarkerSettings(
                        isVisible: true,
                        width: _screenController.screenSize.value.getHeightPerSize(1),
                        height: _screenController.screenSize.value.getHeightPerSize(1),
                        color: Colors.blue, // 포인터 색상
                      ),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      dataLabelMapper: (SalesData sales, _) =>
                          NumberFormat('#,###').format(sales.sales),
                    ),
                  ],
                ),
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
                title: '1주 평균',
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
  final ScreenController _screenController = Get.find<ScreenController>();
  TradeDetailButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: _screenController.screenSize.value.getWidthPerSize(4),
          right: _screenController.screenSize.value.getWidthPerSize(4)),
      child: Row(
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
