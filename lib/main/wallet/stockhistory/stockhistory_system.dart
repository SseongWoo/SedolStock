import 'package:get/get.dart';

import '../../../data/my_data.dart';
import '../../../data/public_data.dart';

class StockHistoryController extends GetxController {
  final MyDataController _myDataController = Get.find<MyDataController>();
  List<String> itemList = ['전체'] + channelNameList;
  List<String> itemTypeList = ['전체', '조회수', '좋아요수'];
  List<String> saleTypeList = ['전체', '구매', '판매'];
  RxList<String> selectedFilters = <String>['전체'].obs;
  RxString selectItemType = '전체'.obs;
  RxString selectSaleType = '전체'.obs;
  RxList<TradeHistoryClass> historyList = <TradeHistoryClass>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    historyList = _myDataController.tradeHistoryList;
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
    RxList<TradeHistoryClass> setHistoryList = <TradeHistoryClass>[].obs;
    historyList.clear();
    final Map<String, String> itemMapping = {'전체': '전체'}
      ..addAll(Map.fromIterables(channelNameList, channelIdList));
    final Map<String, String> tradeTypeMapping = {
      '구매': 'buy',
      '판매': 'sale',
      '전체': '전체',
    };
    final Map<String, String> itemTypeMapping = {
      '조회수': 'view',
      '좋아요수': 'like',
      '전체': '전체',
    };

    setHistoryList.value = _myDataController.tradeHistoryList.where((trade) {
      final matchItem = selectedFilters.contains('전체') ||
          selectedFilters.any((filter) => trade.itemuid == itemMapping[filter]);
      final matchItemType =
          selectItemType.value == '전체' || trade.itemtype == itemTypeMapping[selectItemType.value];
      final matchSaleType =
          selectSaleType.value == '전체' || trade.type == tradeTypeMapping[selectSaleType.value];
      return matchItem && matchItemType && matchSaleType;
    }).toList();
    historyList = setHistoryList;
  }

  // 필터 초기화 함수
  void resetFilter() {
    selectedFilters.clear();
    selectedFilters.add('전체');
    selectItemType.value = '전체';
    selectSaleType.value = '전체';
  }
}
