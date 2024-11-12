import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/transaction/transaction_screen.dart';
import '../../../data/my_data.dart';
import '../../../data/youtube_data.dart';

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
  String type = '';
  RxInt walletSum = 0.obs;
  RxInt walletReturn = 0.obs;
  RxInt walletAvg = 0.obs;
  RxDouble walletRatio = 0.0.obs;
  RxInt walletCount = 0.obs;
  RxDouble minYValue = 0.0.obs;
  Color textColor = Colors.black;
  Color titleTextColor = Colors.black;
  RxInt stockReturn = 0.obs;
  RxDouble stockRatio = 0.0.obs;
  RxDouble opacity = 0.0.obs;
  RxBool typeMain = true.obs;

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
    ever(
      _myDataController.ownStock,
      (callback) => setDetailData(),
    );
  }

  @override
  void onClose() {
    scrollController.dispose(); // 스크롤 컨트롤러 해제
    super.onClose();
  }

  void setDetailData() {
    // Set minYValue
    minYValue.value = _calculateMinYValue();
    minYValue.value = (minYValue ~/ 10) * 10;

    // Set stock return and ratio
    stockReturn.value = _calculateStockReturn();
    stockRatio.value = (stockReturn.value / _getLastPrice()) * 100;

    // Set wallet details
    walletCount.value = _myDataController.ownStock['${channelUID}_$type']!.stockCount;
    _setWalletDetails();

    setTextColor();
    setTitleTextColor();
  }

// Helper method to calculate minYValue based on type
  double _calculateMinYValue() {
    final chartData = (type == 'view')
        ? _youtubeDataController.youtubeChartData[channelUID]!.viewCount
        : _youtubeDataController.youtubeChartData[channelUID]!.likeCount;
    return chartData.map((data) => data.sales).reduce((a, b) => a < b ? a : b);
  }

  int _calculateStockReturn() {
    final liveData = _youtubeDataController.youtubeLiveData[channelUID]!;
    return (type == 'view')
        ? liveData.viewCountPrice - liveData.lastViewCountPrice
        : liveData.likeCountPrice - liveData.lastLikeCountPrice;
  }

  int _getLastPrice() {
    return (type == 'view')
        ? _youtubeDataController.youtubeLiveData[channelUID]!.lastViewCountPrice
        : _youtubeDataController.youtubeLiveData[channelUID]!.lastLikeCountPrice;
  }

  void _setWalletDetails() {
    if (walletCount.value != 0) {
      walletSum.value = _myDataController.ownStock['${channelUID}_$type']!.stockPrice;
      walletAvg.value = walletSum.value ~/ walletCount.value;

      final currentPrice = (type == 'view')
          ? _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice
          : _youtubeDataController.youtubeLiveData[channelUID]!.likeCountPrice;

      walletReturn.value = walletSum.value - (currentPrice * walletCount.value);
      walletRatio.value = (walletReturn.value / walletSum.value) * 100;
    } else {
      walletAvg.value = 0;
    }
  }

  void setTextColor() {
    if (walletReturn > 0) {
      textColor = Colors.red;
    } else if (walletReturn < 0) {
      textColor = Colors.blue;
    } else {
      textColor = Colors.black;
    }
  }

  void setTitleTextColor() {
    if (stockReturn > 0) {
      titleTextColor = Colors.red;
    } else if (stockReturn < 0) {
      titleTextColor = Colors.blue;
    } else {
      titleTextColor = Colors.black;
    }
  }
}
