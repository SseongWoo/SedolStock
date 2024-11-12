import 'package:get/get.dart';
import 'detail/trade_detail_screen.dart';

class TradeController extends GetxController {
  final List<String> dropdownItemList = ['전체', '조회수', '좋아요수'];
  RxString dropdownItem = '전체'.obs;

  void goTradeItem(String channelUID, String type) {
    Get.to(() => const TradeDetailScreen(), arguments: {'channelUID': channelUID, 'type': type});
  }
}
