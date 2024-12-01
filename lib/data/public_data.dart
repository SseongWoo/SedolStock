import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../main.dart';
import '../utils/data_storage.dart';
import '../utils/get_env.dart';
import '../utils/timer.dart';

// 거래 수수료
double feeRate = 0.05;

List<String> channelIdList = []; // 채널 uid 리스트 데이터
List<String> subChannelIdList = []; // 서브채널 uid 리스트 데이터
// 채널 이름 리스트 데이터
List<String> channelNameList = [
  '우왁굳',
  '아이네',
  '징버거',
  '릴파',
  '주르르',
  '고세구',
  '비챤',
];

// 팬덤명 리스트 데이터
List<String> fanNameList = ['팬치', '이파리', '둘기', '똥강아지', '박쥐단', '주폭도', '세균단', '라니'];
// 영어 팬덤명 리스트 데이터
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

// 팬덤명 맵 데이터
Map<String, String> fanImageMap = Map.fromIterables(fanNameList, fanEnNameList);

Map<String, int> streamerIndexMap = {
  for (int i = 0; i < fanNameList.length; i++) fanNameList[i]: i
};

// 랭킹 데이터 클래스
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
  RxList<RankingDataClass> rankingList = <RankingDataClass>[].obs; // 랭킹 데이터 리스트
  RxString updateDate = ''.obs; // 랭킹 업데이트 날짜

  // 로그아웃 기능 함수
  void logOut() async {
    EasyLoading.show();
    await clearTokens();
    Get.delete<TimerController>();
    EasyLoading.dismiss();
    Get.offAllNamed('/login');
  }
}

// 랭크 데이터를 서버에서 가져오는 함수
Future<void> getRankData() async {
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  final url = Uri.parse('$httpURL/rank/get');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];
      final List<dynamic> dataList = jsonData['users'];
      publicDataController.updateDate.value = jsonData['updatedate'] ?? '';

      publicDataController.rankingList.clear();

      for (var rankData in dataList) {
        int? totalmoney;
        if (rankData['totalmoney'] is double) {
          double doubleMoney = rankData['totalmoney'];
          totalmoney = doubleMoney.round();
        }
        publicDataController.rankingList.add(
          RankingDataClass(
            rankData['name']?.toString() ?? '',
            rankData['choicechannel']?.toString() ?? '',
            rankData['rank'] ?? 0,
            rankData['beforerank'] ?? 0,
            totalmoney ?? rankData['totalmoney'] ?? 0,
          ),
        );
      }
      logger.i('getRankData log : Ranking data stored successfully.');
    } else {
      logger.w(
          'getRankData error : Failed to fetch ranking data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('getRankData error : $e');
  }
}
