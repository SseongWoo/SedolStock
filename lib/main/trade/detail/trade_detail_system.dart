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
  String channelUID = '';
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

  void goTransaction(bool buying) {
    WidgetsBinding.instance.ensureVisualUpdate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.to(() => TransactionScreen(),
          arguments: {'buying': buying, 'channelUID': channelUID, 'stockRatio': stockRatio});
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;
    channelUID = arguments['channelUID'];
    setDetailData();
  }

  void setDetailData() {
    minYValue.value = _youtubeDataController.youtubeChartData[channelUID]!.viewCount
        .map((data) => data.sales)
        .reduce((a, b) => a < b ? a : b);
    minYValue.value = (minYValue ~/ 1000) * 1000;

    stockReturn.value = _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice -
        _youtubeDataController.youtubeLiveData[channelUID]!.lastViewCountPrice;
    stockRatio.value = (stockReturn.value /
            _youtubeDataController.youtubeLiveData[channelUID]!.lastViewCountPrice) *
        100;
    walletCount.value = _myDataController.ownStock['${channelUID}_view']!.stockCount;
    if (walletCount.value != 0) {
      walletSum.value = _myDataController.ownStock['${channelUID}_view']!.stockPrice;
      walletAvg.value = walletSum.value ~/ walletCount.value;
      walletReturn.value = walletSum.value -
          (_youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice * walletCount.value);

      walletRatio.value = (walletReturn.value / walletSum.value) * 100;
    } else {
      walletAvg.value = 0;
    }

    setTextColor();
    setTitleTextColor();
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
