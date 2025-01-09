import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/route_constants.dart';
import '../../../data/my_data.dart';
import '../../../data/youtube_data.dart';
import '../../../model/data/data_class.dart';
import '../../../model/main/trade_model.dart';
import '../../../service/http_service.dart';
import '../../../utils/format.dart';
import '../../../utils/screen_size.dart';

class TradeDetailViewModel extends GetxController {
  final HttpService _httpService = HttpService();
  final ScreenController screenController = Get.find<ScreenController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final ScrollController scrollController = ScrollController();
  RxDouble opacity = 0.0.obs; // 화면 스크롤 위치 값
  RxList<FlSpot> chartSpots = <FlSpot>[].obs; // 가격 그래프 데이터 리스트
  RxList<String> chartXTitle = <String>[].obs; // 가격 그래프 x축 타이틀
  String channelUID = '';
  String type = ''; // 조회수, 좋아요 수 타입 구분 변수
  RxBool typeMain = true.obs; // 아이템의 타입 확인 변수
  RxList<YoutubeVideoDataClass> mainVideoList = <YoutubeVideoDataClass>[].obs;
  RxList<YoutubeVideoDataClass> subVideoList = <YoutubeVideoDataClass>[].obs;
  Rx<TradeDetailChartData> tradeDetailChartData = TradeDetailChartData('', '', '').obs; // 초기화 추가
  Rx<ItemPriceDataClass> itemPriceData =
      ItemPriceDataClass('', '', 0, 0, 0, 0, 0, 0, 0.0, 0, 0).obs; // 아이템 가격 데이터 클래스
  Rx<MyStockDataClass> myStockDataClass = MyStockDataClass('', 0, 0, '').obs;
  RxInt profit = 0.obs;
  String typeLabel = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    channelUID = arguments['channelUID'];
    type = arguments['type'];
    itemPriceData.value = youtubeDataController.itemPriceDateMap['${channelUID}_$type']!;

    typeLabel = type == 'view' ? '조회수' : '좋아요수';

    scrollController.addListener(() {
      // 스크롤 위치에 따라 투명도 변경 (최대 100까지 스크롤 시 1.0의 불투명도)
      double offset = scrollController.position.pixels;
      opacity.value = (offset / 100).clamp(0.0, 1.0);
    });

    setMyHoldStockData();
    setChartData();
    setVideoListData();
  }

  // 주식 매매 화면으로 이동하는 볒변수
  void goTransaction(bool buying) {
    Get.toNamed(
      AppRoute.tradeDealing,
      arguments: {'buying': buying, 'channelUID': channelUID, 'type': type},
    );
  }

  // 내 보유중인 주식 데이터 섷정
  void setMyHoldStockData() {
    final stockData = _myDataController.stockListItem['${channelUID}_$type'];
    String pm = '';

    // 주식 수량이 0인 경우 예외를 방지하기 위한 기본값 처리
    if (stockData == null) {
      myStockDataClass.value.holdAvgPrice = '0P';
      myStockDataClass.value.holdCount = 0;
      myStockDataClass.value.holdTotalPrice = 0;
      myStockDataClass.value.holdReturnRatio = '0P (0.00%)';
      return;
    }

    myStockDataClass.value.holdAvgPrice = '${formatToCurrency(stockData.stockBuyingPrice)}P';
    myStockDataClass.value.holdCount = stockData.stockCount;
    myStockDataClass.value.holdTotalPrice = stockData.stockTotalPrice;
    if (stockData.stockProfit > 0) {
      pm = '+';
    }
    profit.value = stockData.stockProfit;
    myStockDataClass.value.holdReturnRatio =
        '$pm${formatToCurrency(stockData.stockProfit)}P (${((stockData.stockRatio).toStringAsFixed(2))}%)';
  }

  // 그래프에 사용될 데이터 설정
  void setChartData() {
    itemPriceData.value = youtubeDataController.itemPriceDateMap['${channelUID}_$type']!;
    tradeDetailChartData.value.title =
        '${youtubeDataController.channelMapData[channelUID]!} (${type == 'view' ? '조회수' : '좋아요수'})';
    tradeDetailChartData.value.price = formatToCurrency(itemPriceData.value.price);

    tradeDetailChartData.value.returnRatio =
        '${itemPriceData.value.differencePrice > 0 ? '+' : ''}${itemPriceData.value.differencePrice} (${itemPriceData.value.ratio > 0 ? '+' : ''}${itemPriceData.value.ratio.toStringAsFixed(2)}%)';

    List<SalesData> reversedCount = [];
    if (type == 'view') {
      reversedCount =
          youtubeDataController.youtubeChartData[channelUID]!.viewCount.take(10).toList();
    } else {
      reversedCount =
          youtubeDataController.youtubeChartData[channelUID]!.likeCount.take(10).toList();
    }
    final List<SalesData> last10ReversedCount = reversedCount.reversed.toList();

    List<String> xtitle = [];
    List<FlSpot> spots = last10ReversedCount.asMap().entries.map((entry) {
      final int index = entry.key;
      final SalesData data = entry.value;
      xtitle.add(data.time);
      return FlSpot(index.toDouble(), data.sales);
    }).toList();

    chartSpots.value = spots;
    chartXTitle.value = xtitle;
  }

  // 그래프 y축 최대값 설정
  double chartMaxValue() {
    final maxValue = chartSpots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    int digitCount = maxValue.toInt().toString().length;
    int baseValue = pow(10, digitCount - 1).toInt();

    return ((maxValue / baseValue).ceil() * baseValue) + baseValue.toDouble();
  }

  // 비디오 영상 설정
  void setVideoListData() {
    mainVideoList.value = youtubeDataController.youtubeVideoData[channelUID]!;
    subVideoList.value = youtubeDataController
        .youtubeVideoData[youtubeDataController.channelAndSubChannelMapData[channelUID]]!;
  }

  // 메인, 서브 영상 리스트 설정
  List<YoutubeVideoDataClass> getVideoListData() {
    if (typeMain.value) {
      return mainVideoList;
    } else {
      return subVideoList;
    }
  }

  // 메인 서브 영상 변경버튼
  void onTapVideoListInkWell() {
    typeMain.value = !typeMain.value;
  }

  // 유튜브 이동 버튼
  void onTapVideListIconButton(int index) {
    _httpService.openUrl(
        getVideoListData()[index].videoUrl, '오류가 발생했습니다. 네트워크 연결을 확인하거나, 다시 시도해주세요.');
  }

  // 상장폐지 확인 함수
  bool delistingState() {
    return itemPriceData.value.delisting > 0;
  }

  // 상장폐지 텍스트
  String delistingTitle() {
    return '상장 폐지중(${itemPriceData.value.delisting})';
  }

  int diffText(bool main) {
    int value = main
        ? itemPriceData.value.totalCount - itemPriceData.value.beforeTotalCount
        : itemPriceData.value.subTotalCount - itemPriceData.value.subBeforeTotalCount;

    return value;
  }
}
