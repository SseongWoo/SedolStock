import 'package:get/get.dart';
import '../../../data/my_data.dart';
import '../../trade/detail/trade_detail_screen.dart';

class StockListController extends GetxController {
  RxBool isExpanded = false.obs;
  // 보유 주식을 클릭했을때 해당 주식 상세정보로 이동
  void goTradeItem(String channelUID, String type) {
    Get.to(() => const TradeDetailScreen(), arguments: {'channelUID': channelUID, 'type': type});
  }

  // 클릭시 파이차트가 나타나거나 사라지게 하는 함수
  void toggle() {
    isExpanded.value = !isExpanded.value;
  }
}
