import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'check_list.dart';

late String httpURL = 'http://localhost:3000/api';
late String cafeURL;

void setURL() {
  cafeURL = dotenv.env['CAFE_URL'] ?? '';
  httpURL = dotenv.env['API_URL'] ?? '';
}
