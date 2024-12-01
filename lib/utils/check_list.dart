import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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

// 버전 체크 함수
void checkVersion() {
  // 추후에 추가 예정
}

// 서버가 열렸는지 확인하는 함수
Future<bool> checkServer() async {
  try {
    Uri uri = Uri.parse('$httpURL/running');
    final running = await http.get(uri);

    if (running.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    logger.e('checkServer error : $e');
    return false;
  }
}
