import 'check_platform.dart';

String httpURL = 'http://localhost:3000';

void setURL() {
  if (checkPlatform() == 'AOS') {
    httpURL = 'http://10.0.2.2:3000';
  } else {
    httpURL = 'http://localhost:3000';
  }
}
