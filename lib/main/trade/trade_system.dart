import 'package:get/get.dart';
import 'detail/trade_detail_screen.dart';

class TradeController extends GetxController {
  void goTradeItem(String channelUID) {
    Get.to(() => const TradeDetailScreen(), arguments: {'channelUID': channelUID});
  }
}
