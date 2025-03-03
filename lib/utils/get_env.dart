import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

late String httpURL;
late String cafeURL;
late String packageName;

//env파일에서 데이터를 가져오는 함수
void setURL() {
  cafeURL = dotenv.env['CAFE_URL'] ?? '';
  httpURL = dotenv.env['API_URL'] ?? '';
  packageName = dotenv.env['PACKAGE_NAME'] ?? '';

  if (kDebugMode) {
    print('디버그 모드에서 실행 중입니다.');
    httpURL = dotenv.env['TEST_API_URL'] ?? '';
    //httpURL = 'http://localhost:3000/api';
    //httpURL = dotenv.env['TEST_SERVER_API_URL'] ?? '';
  } else {
    print('릴리스 모드에서 실행 중입니다.');
  }
}

// 각각 메인, 서브 채널의 uid를 가져오는 함수
List<String> getTotalChannelIdList() {
  return [
    ...dotenv.get('CHANNEL_ID_LIST').split(','),
    ...dotenv.get('SUB_CHANNEL_ID_LIST').split(',')
  ];
}

List<String> getChannelIdList() {
  return dotenv.get('CHANNEL_ID_LIST').split(',');
}

List<String> getSubChannelIdList() {
  return dotenv.get('SUB_CHANNEL_ID_LIST').split(',');
}
