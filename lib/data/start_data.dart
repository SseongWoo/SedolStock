import 'package:intl/intl.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/information_system.dart';
import '../main/trade/detail/trade_detail_system.dart';
import '../utils/data_storage.dart';
import 'my_data.dart';

// 하루에 한번만 실행되는 함수
Future<void> fetchDataAndSave(String today) async {
  await getLatestYoutubeData();
  saveLatestYoutubeData();
  await getYoutubeChannelData();
  saveYoutubeChannelData();
  await getYoutubeVideoData();
  saveYoutubeVideoData();
  await getRankData();
  saveRankingData();
  await setDataDate(today);
}

// 앱을 실행할때 실행되는 함수
Future<void> startGetData() async {
  final MyDataController myDataController = Get.find<MyDataController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  final InformationController informationController = Get.find<InformationController>();
  String? date = await getDataDate();
  String today = DateFormat('MM월 dd일 hh시').format(DateTime.now());
  DateTime? dateTime = date != null ? DateFormat('MM월 dd일 hh시').parse(date) : null;

  // 금일 새벽 2시 이후 실행된 이력이 있으면 일부 데이터만 가져오고, 없으면 모든 데이터를 가져오도록 동작
  if (date == null ||
      date != today ||
      (dateTime != null && dateTime.hour < 2 && DateTime.now().hour >= 2)) {
    await fetchDataAndSave(today);
  } else {
    await loadLatestYoutubeData();
    await loadYoutubeChannelData();
    await loadYoutubeVideoData();
    await loadRankingData();

    if (youtubeDataController.latestYoutubeData.isEmpty ||
        youtubeDataController.youtubeChannelData.isEmpty ||
        youtubeDataController.youtubeVideoData.isEmpty ||
        publicDataController.rankingList.isEmpty) {
      await fetchDataAndSave(today);
    }
  }

  await getYoutubeLiveData();
  myDataController.setMoneyData();
  await getTradeHistoryData();
  informationController.startController();
  if (Get.isRegistered<TradeDetailController>()) {
    final TradeDetailController tradeDetailController = Get.find<TradeDetailController>();
    tradeDetailController.setChartData();
  }
}

// 앱 실행중 5분마다 실행되거나, 특정 동작으로 실행되는 함수로 사용자의 정보와 주식의 정보를 업데이트 함
Future<void> reflashGetData(bool timeReFlash) async {
  final MyDataController myDataController = Get.find<MyDataController>();
  final InformationController informationController = Get.find<InformationController>();
  await getUserData();
  await getWalletData();

  if (!timeReFlash) {
    myDataController.setMoneyData();
    await getTradeHistoryData();
  }
  await updateMyTotalMoney();

  informationController.profitRate(); // 수익률 업데이트
  informationController.setMoneyChartData(); // 차트 데이터 업데이트
}
