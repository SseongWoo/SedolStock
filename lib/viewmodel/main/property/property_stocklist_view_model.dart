import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stockpj/constants/route_constants.dart';
import '../../../data/my_data.dart';
import '../../../data/youtube_data.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/format.dart';
import '../../../utils/screen_size.dart';

class PropertyStocklistViewModel extends GetxController {
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();

  // 파이차트 확장 상태관리
  RxBool isExpandedChart = false.obs;
  // 각 아이템의 확장 상태 관리
  RxMap<String, bool> expandedState = <String, bool>{}.obs;

  // 보유 주식을 클릭했을때 해당 주식 상세정보로 이동
  void goTradeItem(String channelUID, String type) {
    Get.toNamed(AppRoute.tradeDetail, arguments: {'channelUID': channelUID, 'type': type});
  }

  // 파이차트 확장/축소 상태 변경
  void toggleChartExpansion() {
    isExpandedChart.value = !isExpandedChart.value;
  }

  // 특정 아이템의 확장 상태 토글
  void toggleItemExpansion(String stockUID) {
    expandedState[stockUID] = !(expandedState[stockUID] ?? false);
  }

  // 특정 아이템의 확장 상태 가져오기
  bool isItemExpanded(String stockUID) {
    return expandedState[stockUID] ?? false;
  }

  String getThumbnail(StockListClass listData) {
    return listData.stockType == 'view'
        ? youtubeDataController.youtubeChannelData[listData.stockUID]!.thumbnail
        : youtubeDataController
            .youtubeChannelData[
                youtubeDataController.channelAndSubChannelMapData[listData.stockUID]]!
            .thumbnail;
  }

  String getChannelTitle(StockListClass listData) {
    return listData.stockType == 'view'
        ? youtubeDataController.youtubeChannelData[listData.stockUID]!.title
        : youtubeDataController
            .youtubeChannelData[
                youtubeDataController.channelAndSubChannelMapData[listData.stockUID]]!
            .title;
  }
}
