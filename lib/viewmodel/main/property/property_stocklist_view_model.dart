import 'package:get/get.dart';
import 'package:stockpj/constants/route_constants.dart';
import 'package:stockpj/widget/simple_widget.dart';
import '../../../data/my_data.dart';
import '../../../data/youtube_data.dart';
import '../../../model/main/trade_model.dart';
import '../../../utils/screen_size.dart';

// 거래 내역 리스트 뷰 모델
class PropertyStocklistViewModel extends GetxController {
  final TradeModel tradeModel = TradeModel();
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();

  // 파이차트 확장 상태관리
  RxBool isExpandedChart = false.obs;

  // 보유 주식을 클릭했을때 해당 주식 상세정보로 이동
  void goTradeItem(String channelUID) {
    Get.toNamed(AppRoute.tradeDetail, arguments: {'channelUID': channelUID});
  }

  // 파이차트 확장/축소 상태 변경
  void toggleChartExpansion() {
    isExpandedChart.value = !isExpandedChart.value;
  }

  void deleteDelistingItem(String channelUID) {
    showSimpleDialog3(
      screenController.screenSize.value,
      '종목 삭제',
      '상장폐지된 아이템을 삭제하시겠습니끼?',
      '확인',
      () {
        tradeModel.fetchDeleteItem(myDataController.myUid.value, channelUID);
        myDataController.stockListItem.remove(channelUID);
        Get.back();
      },
    );
  }
}
