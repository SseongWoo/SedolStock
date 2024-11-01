import 'package:intl/intl.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/information_system.dart';
import 'package:stockpj/main/trade/detail/trade_detail_system.dart';
import '../utils/data_storage.dart';
import 'my_data.dart';

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

Future<void> startGetData() async {
  final MyDataController myDataController = Get.find<MyDataController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  String? date = await getDataDate();
  String today = DateFormat('MM월 dd일 hh시').format(DateTime.now());
  DateTime? dateTime = date != null ? DateFormat('MM월 dd일 hh시').parse(date) : null;

  if (date == null ||
      date != today ||
      (dateTime != null && dateTime.hour < 2 && DateTime.now().hour >= 2)) {
    await fetchDataAndSave(today);
    print('1번');
  } else {
    await loadLatestYoutubeData();
    await loadYoutubeChannelData();
    await loadYoutubeVideoData();
    await loadRankingData();
    print('2번');

    if (youtubeDataController.latestYoutubeData.isEmpty ||
        youtubeDataController.youtubeChannelData.isEmpty ||
        youtubeDataController.youtubeVideoData.isEmpty ||
        publicDataController.rankingList.isEmpty) {
      await fetchDataAndSave(today);
      print('3번');
    }
  }

  await getYoutubeLiveData();
  myDataController.setMoneyData();
  await getTradeHistoryData();
}

Future<void> reflashGetData(bool timeReFlash) async {
  final MyDataController myDataController = Get.find<MyDataController>();
  final TradeDetailController tradeDetailController = Get.find<TradeDetailController>();
  final InformationController informationController = Get.find<InformationController>();
  await getUserData();
  await getWalletData();

  if (!timeReFlash) {
    myDataController.setMoneyData();
    await getTradeHistoryData();
  }

  tradeDetailController.setDetailData();

  await updateMyTotalMoney();
  informationController.profitRate();
  informationController.setMoneyChartData();
}
