import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/route_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../data/my_data.dart';
import '../../../data/youtube_data.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/color.dart';
import '../../../utils/format.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/timer.dart';

class TradeViewModel extends GetxController {
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final TimerController _timerController = Get.find<TimerController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final List<String> dropdownItemList = ['전체', '메인', '서브']; // 거래 아이템 필터
  final RxList<ItemPriceDataClass> itemPriceDataList = <ItemPriceDataClass>[].obs; // 아이템 가격 데이터
  RxString selectItemType = '전체'.obs; // 아이템 타입 필터
  RxBool ascending = true.obs; // 정렬 기능 오름차순 내림차순
  RxString sortType = 'age'.obs; // 정렬 타입

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sortList();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(youtubeDataController.itemPriceDateMap, (value) {
      sortList();
    });
  }

  // 아이템 상세 정보 화면으로 이동
  void goTradeItem(String channelUID) {
    Get.toNamed(
      AppRoute.tradeDetail,
      arguments: {'channelUID': channelUID},
    );
  }

  // 정렬 아이콘 호출 기능
  Icon sortIcon(String itemType) {
    if (itemType == sortType.value) {
      return ascending.value ? const Icon(Icons.expand_less) : const Icon(Icons.expand_more);
    } else {
      return const Icon(Icons.unfold_more);
    }
  }

  // 정렬 버튼 클릭 이벤트
  void onPresedSortButton(String itemType) {
    if (itemType == sortType.value) {
      ascending.value = !ascending.value;
    } else {
      sortType.value = itemType;
      ascending.value = true;
    }
    sortList();
  }

  // 아이템 필터 조정 함수
  void selectItemTypeFilter(String filter) {
    if (selectItemType.value != filter) {
      selectItemType.value = filter;
    }

    sortList();
  }

  // 타이머 바 색 설정
  Color loadingBarColor() {
    return fanColorMap[_myDataController.myChoicechannel.value] ?? colorMAIN;
  }

  // 타이머 바 길이 설정
  double loadingBarWidth() {
    double width = !_timerController.checkDataTime.value
        ? screenController.screenSize.value.getWidthSize() *
            (_timerController.secondsRemaining.value / 180)
        : 0;

    if (width < 0) width = 0.0;

    return width;
  }

  // 가격 텍스트 생성
  String setPriceTitle(String channelUID) {
    return youtubeDataController.itemPriceDateMap[channelUID]!.delisting > 0
        ? '상장 폐지'
        : formatToCurrency(youtubeDataController.itemPriceDateMap[channelUID]!.price);
  }

  // 아이템 정렬
  void sortList() {
    List<ItemPriceDataClass> sortList = [];
    itemPriceDataList.clear();

    switch (sortType.value) {
      // 기본 정렬상태
      case 'age':
        sortList = basicSort();
        break;
      // price 기준 오름차순 정렬
      case 'price':
        sortList = youtubeDataController.itemPriceDateMap.values
            .where((item) =>
                selectItemType.value == '전체' ||
                selectItemType.value == (item.channelType == 'main' ? '메인' : '서브'))
            .toList()
          ..sort((a, b) => a.price.compareTo(b.price));
        sortList = sortList.reversed.toList();
        break;
      // differencePrice 기준 오름차순 정렬
      case 'diffPrice':
        sortList = youtubeDataController.itemPriceDateMap.values
            .where((item) =>
                selectItemType.value == '전체' ||
                selectItemType.value == (item.channelType == 'main' ? '메인' : '서브'))
            .toList()
          ..sort((a, b) => a.differencePrice.compareTo(b.differencePrice));
        sortList = sortList.reversed.toList();
        break;
    }

    if (!ascending.value) {
      sortList = sortList.reversed.toList();
    }

    itemPriceDataList.value = sortList;
  }

  // 기본 정렬 리스트
  List<ItemPriceDataClass> basicSort() {
    List<ItemPriceDataClass> basicList = [];
    if (selectItemType.value == '전체' || selectItemType.value == '메인') {
      for (var item in youtubeDataController.channelIdList) {
        basicList.add(youtubeDataController.itemPriceDateMap[item]!);
      }
    }
    for (var item in youtubeDataController.subChannelIdList) {
      if (selectItemType.value == '전체' || selectItemType.value == '서브') {
        basicList.add(youtubeDataController.itemPriceDateMap[item]!);
      }
    }

    return basicList;
  }
}
