import 'package:get/get.dart';

String checkPlatform() {
  if (GetPlatform.isAndroid) {
    return 'AOS';
  } else if (GetPlatform.isIOS) {
    return 'IOS';
  } else {
    return 'WEB';
  }
}
