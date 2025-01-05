import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/main.dart';
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
  final PublicDataController publicDataController = Get.find<PublicDataController>();

  try {
    Uri uri = Uri.parse('$httpURL/running');
    final running = await http.get(uri);

    if (running.statusCode == 200) {
      final jsonData = jsonDecode(running.body);
      String storeVersionData = jsonData['version']['versionName'];
      publicDataController.storeBuild.value = jsonData['version']['versionCode'];

      RegExp regex = RegExp(r'\(([^)]+)\)');
      Match? match = regex.firstMatch(storeVersionData);

      if (match != null) {
        publicDataController.storeVersion.value = match.group(1)!;
      } else {
        publicDataController.storeVersion.value = '0.0.0';
      }
      return true;
    } else {
      return false;
    }
  } catch (e) {
    logger.e('checkServer error : $e');
    return false;
  }
}

// 이메일 형식인지 확인하는 함수
bool isValidEmail(String email) {
  return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
}
