import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../utils/data_storage.dart';
import '../utils/get_env.dart';
import '../utils/timer.dart';

double feeRate = 0.05;

List<String> channelIdList = [];
List<String> subChannelIdList = [];

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
List<String> fanEnNameList = [
  'Penchi',
  'Ifari',
  'Dulgi',
  'Ddonggangaji',
  'Bakjuidan',
  'Jupukdo',
  'Segyundan',
  'Rani'
];

Map<String, String> fanImageMap = Map.fromIterables(fanNameList, fanEnNameList);

Map<String, int> streamerIndexMap = {
  for (int i = 0; i < fanNameList.length; i++) fanNameList[i]: i
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
            rankData['choicechannel']?.toString() ?? '',
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
