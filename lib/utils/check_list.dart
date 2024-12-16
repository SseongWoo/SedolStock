import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stockpj/main.dart';
import 'package:store_redirect/store_redirect.dart';
import '../data/public_data.dart';
import 'get_env.dart';

// 구동중인 기기의 os를 체크하는 함수
String checkPlatform() {
  if (GetPlatform.isAndroid) {
    return 'AOS';
  } else if (GetPlatform.isIOS) {
    return 'IOS';
  } else {
    return 'WEB';
  }
}

// 서버가 열렸는지 확인하는 함수
Future<bool> checkServer() async {
  try {
    Uri uri = Uri.parse('$httpURL/running');
    final running = await http.get(uri);

    if (running.statusCode == 200) {
      final jsonData = jsonDecode(running.body);

      latestVersion = jsonData['version']['latest_version'];
      latestBuild = jsonData['version']['latest_build'];
      minVersion = jsonData['version']['min_version'];
      minBuild = jsonData['version']['min_build'];

      return true;
    } else {
      return false;
    }
  } catch (e) {
    logger.e('checkServer error : $e');
    return false;
  }
}
