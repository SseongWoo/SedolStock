import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stockpj/main/trade/detail/trade_detail_system.dart';
import 'package:stockpj/utils/date_time.dart';
import 'package:stockpj/utils/format.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/my_data.dart';
import '../../../data/youtube_data.dart';
import '../../../utils/screen_size.dart';

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
          channelMapData[_tradeDetailController.channelUID]!,
          style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.6)),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatToCurrency(_youtubeDataController
                    .youtubeLiveData[_tradeDetailController.channelUID]!.viewCountPrice),
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                ),
              ),
              SizedBox(
                width: _screenController.screenSize.value.getWidthPerSize(2),
              ),
              Text(
                '${_tradeDetailController.stockReturn} (${_tradeDetailController.stockRatio.toStringAsFixed(2)}%)',
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
          BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                channelMapData[_tradeDetailController.channelUID]!,
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2.4),
                ),
              ),
              Row(
                children: [
                  Text(
                    formatToCurrency(_youtubeDataController
                        .youtubeLiveData[_tradeDetailController.channelUID]!.viewCountPrice),
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                    ),
                  ),
                  SizedBox(
                    width: _screenController.screenSize.value.getWidthPerSize(2),
                  ),
                  Text(
                    '${_tradeDetailController.stockReturn} (${_tradeDetailController.stockRatio.toStringAsFixed(2)}%)',
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
                      dataSource: _youtubeDataController
                          .youtubeChartData[_tradeDetailController.channelUID]?.viewCount.reversed
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
                title: '총 조회수',
                trailing: formatToCurrency(_youtubeDataController
                    .youtubeLiveData[_tradeDetailController.channelUID]!.totalViewCount),
                fontSize: 1.6,
              ),
              TradeDetailListTileWidget(
                title: '총 좋아요수',
                trailing: formatToCurrency(_youtubeDataController
                    .youtubeLiveData[_tradeDetailController.channelUID]!.totalLikeCount),
                fontSize: 1.6,
              ),
              TradeDetailListTileWidget(
                title: '이전 총 조회수',
                trailing: formatToCurrency(_youtubeDataController
                    .youtubeLiveData[_tradeDetailController.channelUID]!.lastTotalViewCount),
                fontSize: 1.6,
              ),
              TradeDetailListTileWidget(
                title: '이전 총 좋아요수',
                trailing: formatToCurrency(_youtubeDataController
                    .youtubeLiveData[_tradeDetailController.channelUID]!.lastTotalLikeCount),
                fontSize: 1.6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
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
                    Text(
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
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '최근 업로드된 영상',
              style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.8)),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(100), // 높이 지정
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                // Null 체크 추가: youtubeVideoData[channelUID]가 null이면 0을 반환
                itemCount: _youtubeDataController
                    .youtubeVideoData[_tradeDetailController.channelUID]?.length,
                itemBuilder: (context, index) {
                  final videoData =
                      _youtubeDataController.youtubeVideoData[_tradeDetailController.channelUID];
                  if (videoData == null || videoData.isEmpty) {
                    return const Center(
                      child: Text('영상 데이터를 불러올 수 없습니다.'), // 데이터가 없을 때의 메시지
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
                              return const Center(
                                child: Text('이미지를 불러올 수 없습니다.'), // 오류 시 표시할 텍스트
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
                                // URL을 열 수 없는 경우 처리
                                print('Could not launch $url');
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
          ],
        ),
      ),
    );
  }
}
