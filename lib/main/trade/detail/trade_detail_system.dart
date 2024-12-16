import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/transaction/transaction_screen.dart';
import '../../../data/my_data.dart';
import '../../../data/youtube_data.dart';

// 그래프 데이터 클래스
class SalesData {
  SalesData(this.time, this.sales);
  final String time;
  final double sales;
}

class TradeDetailController extends GetxController {
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final ScrollController scrollController = ScrollController();
  String channelUID = '';
  String type = ''; // 조회수, 좋아요 수 타입 구분 변수
  RxInt walletSum = 0.obs; // 보유중인 주식 총 금액
  RxInt walletReturn = 0.obs; // 보유중인 주식 자산 변동 가격
  RxInt walletAvg = 0.obs; // 보유중인 주식 1주 평균 가격
  RxDouble walletRatio = 0.0.obs; // 보유중인 주식 자산 변동률
  RxInt walletCount = 0.obs; // 보유중인 주식 수
  Color textColor = Colors.black;
  Color titleTextColor = Colors.black;
  RxInt stockReturn = 0.obs; // 주식 변동 가격
  RxDouble stockRatio = 0.0.obs; // 주식 변동률
  RxDouble opacity = 0.0.obs; // 화면 스크롤 위치 값
  RxBool typeMain = true.obs; // 메인, 서브 채널 구분 변수
  List<FlSpot> chartSpots = []; // 가격 그래프 데이터 리스트
  List<String> chartXTitle = []; // 가격 그래프 x축 타이틀

  // 주식 매매 화면으로 이동하는 볒변수
  void goTransaction(bool buying) {
    WidgetsBinding.instance.ensureVisualUpdate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.to(() => TransactionScreen(), arguments: {
        'buying': buying,
        'channelUID': channelUID,
        'stockRatio': stockRatio,
        'type': type
      });
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;
    channelUID = arguments['channelUID'];
    type = arguments['type'];
    setDetailData();
    setChartData();

    // 스크롤 위치가 맨 위일경우 위젯이 안보이고 내려갈수록 위젯이 보이도록 하는 기능
    // 화면의 앱 바의 타이틀부분에 주식 아이템 이름과, 변동률을 넣어서 사용
    scrollController.addListener(() {
      // 스크롤 위치에 따라 투명도 변경 (최대 100까지 스크롤 시 1.0의 불투명도)
      double offset = scrollController.position.pixels;
      opacity.value = (offset / 100).clamp(0.0, 1.0);
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    // 보유한 주식이 변동이 있을때 실행되는 기능
    ever(
      _myDataController.ownStock,
      (callback) => setDetailData(),
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // 보유 주식 데이터값을 업데이트 하는 함수
  void setDetailData() {
    stockReturn.value = _calculateStockReturn();
    stockRatio.value = (stockReturn.value / _getLastPrice()) * 100;

    walletCount.value = _myDataController.ownStock['${channelUID}_$type']!.stockCount;
    _setWalletDetails();

    setTextColor();
    setTitleTextColor();
  }

  // 주식 변동 가격을 설정하기 위한 함수
  int _calculateStockReturn() {
    final liveData = _youtubeDataController.youtubeLiveData[channelUID]!;
    return (type == 'view')
        ? liveData.viewCountPrice - liveData.lastViewCountPrice
        : liveData.likeCountPrice - liveData.lastLikeCountPrice;
  }

  // 현재 주식의 가격을 가져오는 함수
  int _getLastPrice() {
    return (type == 'view')
        ? _youtubeDataController.youtubeLiveData[channelUID]!.lastViewCountPrice
        : _youtubeDataController.youtubeLiveData[channelUID]!.lastLikeCountPrice;
  }

  // 사용자의 자산 데이터를 가져오기 위한 변수
  void _setWalletDetails() {
    if (walletCount.value != 0) {
      final currentPrice = (type == 'view')
          ? _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice
          : _youtubeDataController.youtubeLiveData[channelUID]!.likeCountPrice;

      walletSum.value =
          currentPrice * _myDataController.ownStock['${channelUID}_$type']!.stockCount;
      walletAvg.value = walletSum.value ~/ walletCount.value;

      walletReturn.value =
          walletSum.value - (_myDataController.ownStock['${channelUID}_$type']!.stockPrice);
      walletRatio.value =
          (walletReturn.value / _myDataController.ownStock['${channelUID}_$type']!.stockPrice) *
              100;
    } else {
      walletAvg.value = 0;
    }
  }

  // 이익, 손해 각각의 경우의 색을 설정하는 함수
  void setTextColor() {
    if (walletReturn > 0) {
      textColor = Colors.red;
    } else if (walletReturn < 0) {
      textColor = Colors.blue;
    } else {
      textColor = Colors.black;
    }
  }

  // 이익, 손해 각각의 경우의 색을 설정하는 함수
  void setTitleTextColor() {
    if (stockReturn > 0) {
      titleTextColor = Colors.red;
    } else if (stockReturn < 0) {
      titleTextColor = Colors.blue;
    } else {
      titleTextColor = Colors.black;
    }
  }

  // 차트 데이터 생성 함수
  void setChartData() {
    List<SalesData> reversedCount = [];
    if (type == 'view') {
      reversedCount =
          _youtubeDataController.youtubeChartData[channelUID]!.viewCount.take(10).toList();
    } else {
      reversedCount =
          _youtubeDataController.youtubeChartData[channelUID]!.likeCount.take(10).toList();
    }
    final List<SalesData> last10ReversedCount = reversedCount.reversed.toList();

    chartSpots = last10ReversedCount.asMap().entries.map((entry) {
      final int index = entry.key;
      final SalesData data = entry.value;
      chartXTitle.add(data.time);
      return FlSpot(index.toDouble(), data.sales);
    }).toList();
  }
}
