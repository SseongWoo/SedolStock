import 'package:get/get.dart';
import '../../../data/my_data.dart';
import '../../trade/detail/trade_detail_screen.dart';

class StockListController extends GetxController {
  void goTradeItem(String channelUID, String type) {
    Get.to(() => const TradeDetailScreen(), arguments: {'channelUID': channelUID, 'type': type});
  }
}
