import 'package:get/get.dart';
import 'detail/trade_detail_screen.dart';

class TradeController extends GetxController {
  final List<String> dropdownItemList = ['전체', '조회수', '좋아요수']; // 거래 아이템 필터
  RxString dropdownItem = '전체'.obs;

  // 아이템 상세 정보 화면으로 이동
  void goTradeItem(String channelUID, String type) {
    Get.to(() => const TradeDetailScreen(), arguments: {'channelUID': channelUID, 'type': type});
  }
}
