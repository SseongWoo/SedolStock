import 'package:get/get.dart';

import '../../../data/public_data.dart';

class StockHistoryController extends GetxController {
  List<String> itemList = ['전체'] + channelNameList;
  List<String> itemTypeList = ['전체', '조회수', '좋아요수'];
  List<String> saleTypeList = ['전체', '구매', '판매'];
  RxList<String> selectedFilters = <String>['전체'].obs;
  RxString selectItem = '전체'.obs;
  RxString selectItemType = '전체'.obs;
  RxString selectSaleType = '전체'.obs;

  void selectItemTypeFilter(String filter) {
    if (selectItemType.value != filter) {
      selectItemType.value = filter;
    }
  }

  void selectSaleTypeFilter(String filter) {
    if (selectSaleType.value != filter) {
      selectSaleType.value = filter;
    }
  }

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
}
