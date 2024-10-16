import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stockpj/utils/secure_storage.dart';

class MyData {
  String myUid;
  String myId;
  String firstlogintime;
  String name;
  String choicechannel;

  MyData(this.myUid, this.myId, this.firstlogintime, this.name, this.choicechannel);
}

MyData myData = MyData('', '', '', '', '');

Future<bool> getUserData() async {
  myData.myUid = (await getUID())!;
  final String apiUrl = 'http://localhost:3000/users/${myData.myUid}'; // 서버 URL과 엔드포인트

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      myData.myId = jsonData['data']['id'];
      myData.firstlogintime = jsonData['data']['firstlogintime'];
      myData.name = jsonData['data']['name'];
      myData.choicechannel = jsonData['data']['choicechannel'];
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
