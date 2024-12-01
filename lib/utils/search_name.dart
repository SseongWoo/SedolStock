import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stockpj/main.dart';
import 'package:stockpj/utils/simple_widget.dart';
import 'package:get/get.dart';
import 'get_env.dart';

// 사용자가 설정하고싶은 이름이 이미 등록되어있는 닉네임인지 확인하는 함수
Future<bool> searchName(String name) async {
  try {
    final searchNameData = await http.post(
      Uri.parse('$httpURL/names/$name'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );
    if (searchNameData.statusCode == 200) {
      return true;
    } else if (searchNameData.statusCode == 404) {
      return false;
    } else {
      showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
      return true;
    }
  } catch (e) {
    logger.e('searchName error : $e');
    showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
    return true;
  }
}
