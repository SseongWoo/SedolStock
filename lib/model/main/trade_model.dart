import '../../main.dart';
import '../../service/http_service.dart';

// 차트 제목 클래스
class TradeDetailChartData {
  String title;
  String price;
  String returnRatio;

  TradeDetailChartData({
    required this.title,
    required this.price,
    required this.returnRatio,
  });

  factory TradeDetailChartData.empty() {
    return TradeDetailChartData(
      title: 'N/A',
      price: '0',
      returnRatio: '0%',
    );
  }
}

// 그래프 데이터 클래스
class SalesData {
  SalesData(this.time, this.sales);
  final String time;
  final double sales;
}

class TradeModel {
  // 매매 실행
  Future<int> fetchTrySale(String myUID, int price, int count, String channelUID,
      String channelType, String saleType, int priceAVG) async {
    final HttpService httpService = HttpService();
    try {
      final response = await httpService.putRequest('/trade/$myUID/trade/0', {
        'itemuid': channelUID,
        'channeltype': channelType,
        'itemcount': count,
        'transactionprice': price,
        'tradetype': saleType,
        'priceavg': priceAVG,
      });
      return response.statusCode;
    } catch (e) {
      logger.e('trySale error : $e');
      return 500;
    }
  }

  // 상장 폐지된 아이템 지갑 리스트에서 삭제
  Future<bool> fetchDeleteItem(
    String myUID,
    String channelUID,
  ) async {
    final HttpService httpService = HttpService();
    try {
      final response = await httpService.putRequest('/trade/delete/delistingitem', {
        'uid': myUID,
        'itemuid': channelUID,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        logger.e('fetchDeleteItem error : ${response.statusCode}');
        return false;
      }
    } catch (e) {
      logger.e('fetchDeleteItem error : $e');
      return false;
    }
  }
}
