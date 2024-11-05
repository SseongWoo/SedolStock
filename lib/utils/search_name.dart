import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stockpj/utils/simple_widget.dart';
import 'package:get/get.dart';
import 'http_request.dart';

Future<bool> searchName(String name) async {
  final searchNameData = await http.post(
    Uri.parse('$httpURL/names/$name'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
    }),
  );
  print(searchNameData.statusCode);
  if (searchNameData.statusCode == 200) {
    return true;
  } else if (searchNameData.statusCode == 404) {
    return false;
  } else {
    showSimpleDialog(Get.back, '오류', '오류가 발생했습니다.\n다시 시도해 주세요');
    return true;
  }
}
