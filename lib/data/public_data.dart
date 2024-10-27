import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../utils/http_request.dart';

class RankingDataClass {
  String name;
  String choiceChannel;
  int rank;
  int beforeRank;
  int totalMoney;

  RankingDataClass(this.name, this.choiceChannel, this.rank, this.beforeRank, this.totalMoney);
}

class PublicDataController extends GetxController {
  RxList<RankingDataClass> rankingList = <RankingDataClass>[].obs;
  RxString updateDate = ''.obs;
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

      print(publicDataController.rankingList[0].name);
      print(publicDataController.updateDate.value);

      print('Ranking data stored successfully.');
    } else {
      print('Failed to fetch ranking data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching ranking data: $error');
  }
}
