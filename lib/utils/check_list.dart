import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/main.dart';
import 'format.dart';
import 'get_env.dart';

// 서버가 열렸는지 확인하는 함수
Future<bool> checkServer() async {
  final PublicDataController publicDataController = Get.find<PublicDataController>();

  try {
    Uri uri = Uri.parse('$httpURL/running');
    final running = await http.get(uri).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        logger.e('checkServer timeout');
        return http.Response('Timeout', 408);
      },
    );

    if (running.statusCode == 200) {
      final jsonData = jsonDecode(running.body);
      String storeVersionData = jsonData['version']['versionName'];
      publicDataController.storeBuild.value = jsonData['version']['versionCode'];
      publicDataController.storeVersion.value = formatVersion(storeVersionData);

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

// 앱 버전과 최소 요구 버전 비교
bool checkVersion(String appVersion, String storeVersion) {
  final appParts = appVersion.split('.').map(int.parse).toList();
  final storeParts = storeVersion.split('.').map(int.parse).toList();
  for (int i = 0; i < appParts.length; i++) {
    if (storeParts[i] > appParts[i]) return true; // 현재 버전이 최소 요구 버전보다 낮음
    if (storeParts[i] < appParts[i]) return false; // 현재 버전이 더 높음
  }
  return false; // 버전이 같음
}
