import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../utils/data_storage.dart';
import '../utils/http_request.dart';
import '../utils/timer.dart';

List<String> channelIdList = [
  'UC2b4WRE5BZ6SIUWBeJU8rwg',
  'UCIVFv8AiQLqM9oLHTixrNYw',
  'UCKzfyYWHQ92z_2jUcSABM8Q',
  'UClbYIn9LDbbFZ9w2shX3K0g',
  'UCAHVQ44O81aehLWfy9O6Elw',
  'UC_eeSpMBz8PG4ssdBPnP07g',
  'UC1afpiIuBDcjYlmruAa0HiA',
  'UC7-m6jQLinZQWIbwm9W-1iw',
  'UCQmcltnre6aG9SkDRYZqFIg',
  'UCYxLMfeX1CbMBll9MsGlzmw',
  'UCcA21_PzN1EhNe7xS4MJGsQ',
  'UCj0c1jUr91dTetIQP2pFeLA'
];

List<String> channelNameList = [
  '스텔라이브',
  '강지',
  '아이리 칸나',
  '아야츠노 유니',
  '아라하시 타비',
  '네네코 마시로',
  '시라유키 히나',
  '아카네 리제',
  '아오쿠모 린',
  '텐코 시부키',
  '하나코 나나',
  '유즈하 리코'
];

List<String> fanNameList = [
  '파스텔',
  '강도단',
  '비늘이',
  '아르냥',
  '해둥이',
  '마로',
  '피엔나',
  '뿡댕이',
  '이나리',
  '쿠리미',
  '페토',
  '치코',
  '까악이'
];

Map<String, int> streamerIndexMap = {
  '파스텔': 0,
  '강도단': 1,
  '비늘이': 2,
  '아르냥': 3,
  '해둥이': 4,
  '마로': 5,
  '피엔나': 6,
  '뿡댕이': 7,
  '이나리': 8,
  '쿠리미': 9,
  '페토': 10,
  '치코': 11,
  '까악이': 12,
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
