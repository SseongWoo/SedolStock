import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../data/public_data.dart';
import 'color.dart';

late String httpURL;
late String cafeURL;
late String packageName;

//env파일에서 데이터를 가져오는 함수
void setURL() {
  cafeURL = dotenv.env['CAFE_URL'] ?? '';
  httpURL = dotenv.env['API_URL'] ?? '';
  packageName = dotenv.env['PACKAGE_NAME'] ?? '';

  // httpURL = 'http://localhost:3000/api';
  // httpURL = 'http://10.0.2.2:3000/api';
}

// 각각 메인, 서브 채널의 uid를 가져오는 함수
List<String> getChannelIdList() {
  return dotenv.get('CHANNEL_ID_LIST').split(',');
}

List<String> getSubChannelIdList() {
  return dotenv.get('SUB_CHANNEL_ID_LIST').split(',');
}
