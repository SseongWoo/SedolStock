import 'package:stockpj/main.dart';
import 'package:stockpj/widget/simple_widget.dart';
import 'package:get/get.dart';
import '../constants/data_constants.dart';
import '../model/scarch_name_model.dart';

// 이름 검색을 처리하는 함수
Future<bool> searchName(String name) async {
  final NameModel nameModel = NameModel();
  try {
    if (channelNameSimpleList.contains(name) ||
        fanNameList.contains(name) ||
        fanEnNameList.contains(name.toUpperCase()) ||
        channelEnNameList.contains(name.toUpperCase())) {
      return true;
    }

    final result = await nameModel.searchName(name);
    return result;
  } catch (e) {
    logger.e('searchName error: $e');
    showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
    return true;
  }
}
