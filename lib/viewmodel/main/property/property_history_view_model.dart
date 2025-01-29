import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/youtube_data.dart';
import '../../../constants/data_constants.dart';
import '../../../data/my_data.dart';
import '../../../data/public_data.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/color.dart';
import '../../../utils/format.dart';
import '../../../utils/screen_size.dart';
import '../../../view/main/property/property_history_widget.dart';

// 지갑 탭 거래 내역 뷰 모델
class PropertyHistoryViewModel extends GetxController {
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();

  List<String> itemList = ['전체'] + channelNameSimpleList; // 채널 필터
  List<String> itemTypeList = ['전체', '메인채널', '서브채널']; // 아이템 타입 필터
  List<String> saleTypeList = ['전체', '구매', '판매']; // 매매 타입 필터
  RxList<String> selectedFilters = <String>['전체'].obs; // 채널 필터 선택 목록 리스트
  RxString selectItemType = '전체'.obs; // 선택한 아이템 필터 타입
  RxString selectSaleType = '전체'.obs; // 선택한 매매 필터 타입
  RxList<TradeHistoryClass> historyList = <TradeHistoryClass>[].obs; // 내역 리스트

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    historyList.value = List<TradeHistoryClass>.from(myDataController.tradeHistoryList);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(
      myDataController.tradeHistoryList,
      (callback) =>
          historyList.value = List<TradeHistoryClass>.from(myDataController.tradeHistoryList),
    );
  }

  Widget getProfitReturnWidget(TradeHistoryClass tradeHistoryData) {
    int salePrice = tradeHistoryData.saleavgprice * tradeHistoryData.itemcount;
    int profit = tradeHistoryData.totalcost - salePrice;
    double realizedReturn = (tradeHistoryData.totalcost / salePrice) * 100;
    String pm1 = profit > 0 ? '+' : '';
    String pm2 = profit < 0 ? '-' : '+';

    return Text(
      '$pm1${formatToCurrency(profit)}\n$pm2${realizedReturn.toStringAsFixed(2)}',
      textAlign: TextAlign.center,
      style: TextStyle(color: profitAndLossColor(profit)),
    );
  }

  // 아이템 타입 필터 설정
  void selectItemTypeFilter(String filter) {
    if (selectItemType.value != filter) {
      selectItemType.value = filter;
    }
  }

  // 매매 타입 필터 설정
  void selectSaleTypeFilter(String filter) {
    if (selectSaleType.value != filter) {
      selectSaleType.value = filter;
    }
  }

  // 필터 아이템중 종목명 부분의 버튼을 눌렀을때 실행되는 함수
  void toggleFilter(String filter) {
    if (filter == '전체') {
      if (!selectedFilters.contains('전체')) {
        selectedFilters.clear();
        selectedFilters.add('전체');
      }
    } else {
      if (selectedFilters.contains(filter)) {
        selectedFilters.remove(filter);
        if (selectedFilters.isEmpty) {
          selectedFilters.clear();
          selectedFilters.add('전체');
        }
      } else {
        selectedFilters.remove('전체');
        selectedFilters.add(filter);
      }
    }
  }

  // 사용자가 설정한 필터를 적용하는 함수
  void setfilter() {
    List<String> mainList = List.from(youtubeDataController.channelIdList);
    mainList.removeAt(0);
    Map<String, String> mainToSub =
        Map.fromIterables(youtubeDataController.subChannelIdList, mainList);
    List<TradeHistoryClass> setHistoryList = [];
    final Map<String, String> itemMapping = {'전체': '전체'}
      ..addAll(Map.fromIterables(channelNameSimpleList, youtubeDataController.channelIdList));
    final Map<String, String> tradeTypeMapping = {
      '구매': 'buy',
      '판매': 'sell',
      '전체': '전체',
    };
    final Map<String, String> channelTypeMapping = {
      '메인채널': 'main',
      '서브채널': 'sub',
      '전체': '전체',
    };

    setHistoryList = myDataController.tradeHistoryList.where((trade) {
      final matchItem = selectedFilters.contains('전체') ||
          selectedFilters.any((filter) =>
              trade.itemuid == itemMapping[filter] ||
              mainToSub[trade.itemuid] == itemMapping[filter]);
      final matchItemType = selectItemType.value == '전체' ||
          trade.channeltype == channelTypeMapping[selectItemType.value];
      final matchSaleType =
          selectSaleType.value == '전체' || trade.tradetype == tradeTypeMapping[selectSaleType.value];
      return matchItem && matchItemType && matchSaleType;
    }).toList();
    historyList.value = setHistoryList;
  }

  // 필터 초기화 함수
  void resetFilter() {
    selectedFilters.clear();
    selectedFilters.add('전체');
    selectItemType.value = '전체';
    selectSaleType.value = '전체';
  }

  // 필터 바텀시트 생성
  void createBottomSheet() {
    Get.bottomSheet(PropertyHistoryBottomSheet(
      viewModel: this,
    ));
  }
}
