import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'http_request.dart';

String checkPlatform() {
  if (GetPlatform.isAndroid) {
    return 'AOS';
  } else if (GetPlatform.isIOS) {
    return 'IOS';
  } else {
    return 'WEB';
  }
}

void checkVersion() {
  // 추후에 추가 예정
}

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
    return false;
  }
}
