import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../utils/data_storage.dart';
import '../utils/http_request.dart';
import '../utils/timer.dart';

List<String> channelIdList = [
  'UCBkyj16n2snkRg1BAzpovXQ',
  'UCroM00J2ahCN6k-0-oAiDxg',
  'UCHE7GBQVtdh-c1m3tjFdevQ',
  'UC-oCJP9t47v7-DmsnmXV38Q',
  'UCTifMx1ONpElK5x6B4ng8eg',
  'UCV9WL7sW6_KjanYkUUaIDfQ',
  'UCs6EwgxKLY9GG4QNUrP5hoQ',
];
List<String> subChannelIdList = [
  'UCZOcwheypMvYN_J2oRBgt2A',
  'UCmHltryGykfakS-JmaxrNBg',
  'UC-S9NE-xzcBpxOFSvsmOzAA',
  'UC8dEJs2kpS5x2vI1X7aaUhA',
  'UCgGvSg2lscdNUx9ZJIBh9FQ',
  'UCSSPlgcyDA5eoN3hrkXpvHg',
  'UCuJUfqThFp5-k-lrHcO1dFg',
];

List<String> channelNameList = [
  '우왁굳',
  '아이네',
  '징버거',
  '릴파',
  '주르르',
  '고세구',
  '비챤',
];

List<String> fanNameList = ['팬치', '이파리', '둘기', '똥강아지', '박쥐단', '주폭도', '세균단', '라니'];

Map<String, int> streamerIndexMap = {
  '팬치': 0,
  '이파리': 1,
  '둘기': 2,
  '똥강아지': 3,
  '박쥐단': 4,
  '주폭도': 5,
  '세균단': 6,
  '라니': 7,
};

class RankingDataClass {
  String name;
  String choiceChannel;
  int rank;
  int beforeRank;
  int totalMoney;

  RankingDataClass(
    this.name,
    this.choiceChannel,
    this.rank,
    this.beforeRank,
    this.totalMoney,
  );

  Map<String, dynamic> toJson() => {
        'name': name,
        'choiceChannel': choiceChannel,
        'rank': rank,
        'beforeRank': beforeRank,
        'totalMoney': totalMoney,
      };

  factory RankingDataClass.fromJson(Map<String, dynamic> json) {
    return RankingDataClass(
      json['name'] ?? '',
      json['choiceChannel'] ?? '',
      json['rank'] ?? 0,
      json['beforeRank'] ?? 0,
      json['totalMoney'] ?? 0,
    );
  }
}

class PublicDataController extends GetxController {
  RxList<RankingDataClass> rankingList = <RankingDataClass>[].obs;
  RxString updateDate = ''.obs;

  void logOut() async {
    EasyLoading.show();
    await clearTokens();
    Get.delete<TimerController>();
    EasyLoading.dismiss();
    Get.offAllNamed('/login');
  }
}

Future<void> getRankData() async {
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  final url = Uri.parse('$httpURL/rank/get');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // 서버로부터 받아온 데이터를 JSON으로 디코딩
      final jsonData = jsonDecode(response.body)['data'];
      final List<dynamic> dataList = jsonData['users'];
      publicDataController.updateDate.value = jsonData['updatedate'] ?? '';

      // 기존 데이터 초기화
      publicDataController.rankingList.clear();

      // 데이터 매핑 및 추가
      for (var rankData in dataList) {
        publicDataController.rankingList.add(
          RankingDataClass(
            rankData['name']?.toString() ?? '',
            rankData['choiceChannel']?.toString() ?? '',
            rankData['rank'] ?? 0,
            rankData['beforerank'] ?? 0,
            rankData['totalmoney'] ?? 0,
          ),
        );
      }

      print('Ranking data stored successfully.');
    } else {
      print('Failed to fetch ranking data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching ranking data: $error');
  }
}
