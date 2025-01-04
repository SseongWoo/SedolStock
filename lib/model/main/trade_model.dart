import '../../data/youtube_data.dart';
import '../../main.dart';
import '../../service/http_service.dart';
import 'package:get/get.dart';

// TradeItemWidget에 필요한 데이터를 포함하는 클래스
class TradeItemData {
  final String title;
  final String thumbnail;
  final String priceTitle;
  final String channelUID;
  final String type;
  final ItemPriceDataClass itemPriceDataClass;

  TradeItemData({
    required this.title,
    required this.thumbnail,
    required this.priceTitle,
    required this.channelUID,
    required this.type,
    required this.itemPriceDataClass,
  });
}

class AppBarTitleDataClass {
  String title;
  String price;
  String retnRatio;

  AppBarTitleDataClass(this.title, this.price, this.retnRatio);
}

class TradeDetailChartData {
  String title;
  String price;
  String returnRatio;

  TradeDetailChartData(this.title, this.price, this.returnRatio);
}

class TradeDetailChartInfoClass {
  String title;
  String trailing;

  TradeDetailChartInfoClass(this.title, this.trailing);
}

class MyStockDataClass {
  String holdAvgPrice;
  int holdCount;
  int holdTotalPrice;
  String holdReturnRatio;
  MyStockDataClass(this.holdAvgPrice, this.holdCount, this.holdTotalPrice, this.holdReturnRatio);
}

// 그래프 데이터 클래스
class SalesData {
  SalesData(this.time, this.sales);
  final String time;
  final double sales;
}

class TradeModel {
  // 매매 실행
  Future<bool> trySale(String myUID, int price, int count, String channelUID, String itemType,
      String saleType, int priceAVG) async {
    final HttpService httpService = HttpService();
    try {
      final response = await httpService.putRequest('/trade/$myUID/trade/0', {
        'itemuid': channelUID,
        'itemtype': itemType,
        'itemcount': count,
        'transactionprice': price,
        'type': saleType,
        'priceavg': priceAVG,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      logger.e('updateFandom error : $e');
      return false;
    }
  }
}
