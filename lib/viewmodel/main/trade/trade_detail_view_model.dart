import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
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
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final ScrollController scrollController = ScrollController();
  RxDouble opacity = 0.0.obs; // 화면 스크롤 위치 값
  RxList<FlSpot> chartSpots = <FlSpot>[].obs; // 가격 그래프 데이터 리스트
  RxList<String> chartXTitle = <String>[].obs; // 가격 그래프 x축 타이틀
  String channelUID = '';
  RxList<YoutubeVideoDataClass> videoList = <YoutubeVideoDataClass>[].obs;
  Rx<TradeDetailChartData> tradeDetailChartData = TradeDetailChartData.empty().obs; // 초기화 추가
  Rx<ItemPriceDataClass> itemPriceData = ItemPriceDataClass.empty().obs; // 아이템 가격 데이터 클래스
  RxBool event = false.obs; // 이벤트 유무

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    channelUID = arguments['channelUID'];
    itemPriceData.value = youtubeDataController.itemPriceDateMap[channelUID]!;

    scrollController.addListener(() {
      // 스크롤 위치에 따라 투명도 변경 (최대 100까지 스크롤 시 1.0의 불투명도)
      double offset = scrollController.position.pixels;
      opacity.value = (offset / 100).clamp(0.0, 1.0);
    });

    //setMyHoldStockData();
    setChartData();
    videoList.value = youtubeDataController.youtubeVideoData[channelUID]!;

    event.value = _publicDataController.eventChannelList[channelUID] != null;
  }

  // 주식 매매 화면으로 이동하는 볒변수
  void goTransaction(bool buying) {
    Get.toNamed(
      AppRoute.tradeDealing,
      arguments: {'buying': buying, 'channelUID': channelUID},
    );
  }

  // 내 보유중인 주식 데이터 섷정
  String setReturnRatio(int stockProfit, double stockRatio) {
    String pm = '';
    if (stockProfit > 0) {
      pm = '+';
    }
    return '$pm${formatToCurrency(stockProfit)}P (${((stockRatio).toStringAsFixed(2))}%)';
  }

  // 그래프에 사용될 데이터 설정
  void setChartData() {
    itemPriceData.value = youtubeDataController.itemPriceDateMap[channelUID]!;
    tradeDetailChartData.value.title = youtubeDataController.youtubeChannelData[channelUID]!.title;
    tradeDetailChartData.value.price = formatToCurrency(itemPriceData.value.price);

    tradeDetailChartData.value.returnRatio =
        '${itemPriceData.value.differencePrice > 0 ? '+' : ''}${formatToCurrency(itemPriceData.value.differencePrice)} (${itemPriceData.value.ratio > 0 ? '+' : ''}${(itemPriceData.value.ratio.isFinite) ? itemPriceData.value.ratio.toStringAsFixed(2) : '0.00'}%)';

    List<SalesData> reversedCount = [];
    reversedCount = youtubeDataController.youtubeChartData[channelUID]!.take(10).toList();
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

  // 유튜브 이동 버튼
  void onTapVideListIconButton(int index) {
    _httpService.openUrl(videoList[index].videoUrl, '오류가 발생했습니다. 네트워크 연결을 확인하거나, 다시 시도해주세요.');
  }

  // 상장폐지 확인 함수
  bool delistingState(int delisting) {
    return delisting > 0;
  }

  // 상장폐지 텍스트
  String delistingTitle() {
    return '상장 폐지중(${itemPriceData.value.delisting})';
  }

  // 툴팁 설정
  String setToolTip() {
    return '${_publicDataController.eventChannelList[channelUID] ?? '1'}배 이벤트 중';
  }
}
