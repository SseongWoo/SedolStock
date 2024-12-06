import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../data/public_data.dart';
import 'color.dart';

late String httpURL;
late String cafeURL;

//env파일에서 데이터를 가져오는 함수
void setURL() async {
  cafeURL = dotenv.env['CAFE_URL'] ?? '';
  httpURL = dotenv.env['API_URL'] ?? '';
  channelIdList = dotenv.get('CHANNEL_ID_LIST').split(',');
  subChannelIdList = dotenv.get('SUB_CHANNEL_ID_LIST').split(',');

  //httpURL = 'http://localhost:3000/api';
  setStreamerColorMap();
}
