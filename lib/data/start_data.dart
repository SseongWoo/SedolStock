import 'package:intl/intl.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:get/get.dart';
import '../service/storage_service.dart';
import '../viewmodel/main/trade/trade_detail_view_model.dart';
import 'my_data.dart';

// 하루에 한번만 실행되는 함수
Future<void> fetchDataAndSave(YoutubeDataController youtubeDataController,
    PublicDataController publicDataController, String today) async {
  await youtubeDataController.getLatestYoutubeData();
  saveLatestYoutubeData();
  await youtubeDataController.getYoutubeChannelData();
  saveYoutubeChannelData();
  await youtubeDataController.getYoutubeVideoData();
  saveYoutubeVideoData();
  await publicDataController.getRankData();
  saveRankingData();
  await setDataDate(today);
}

// 앱을 실행할때 실행되는 함수
Future<void> startGetData() async {
  final MyDataController myDataController = Get.find<MyDataController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  String? date = await getDataDate();
  String today = DateFormat('MM월 dd일 hh시').format(DateTime.now());
  DateTime? dateTime = date != null ? DateFormat('MM월 dd일 hh시').parse(date) : null;

  // 금일 새벽 2시 이후 실행된 이력이 있으면 일부 데이터만 가져오고, 없으면 모든 데이터를 가져오도록 동작
  if (date == null ||
      date != today ||
      (dateTime != null && dateTime.hour < 2 && DateTime.now().hour >= 2)) {
    await fetchDataAndSave(youtubeDataController, publicDataController, today);
  } else {
    await loadLatestYoutubeData();
    await loadYoutubeChannelData();
    await loadYoutubeVideoData();
    await loadRankingData();

    if (youtubeDataController.latestYoutubeData.isEmpty ||
        youtubeDataController.youtubeChannelData.isEmpty ||
        youtubeDataController.youtubeVideoData.isEmpty ||
        publicDataController.rankingList.isEmpty) {
      await fetchDataAndSave(youtubeDataController, publicDataController, today);
    }
  }

  await youtubeDataController.getYoutubeLiveData();
  myDataController.setMoneyData();
  await myDataController.getTradeHistoryData();
  if (Get.isRegistered<TradeDetailViewModel>()) {
    final TradeDetailViewModel tradeDetailViewModel = Get.find<TradeDetailViewModel>();
    tradeDetailViewModel.setChartData();
  }
  await myDataController.getMessage();
}

// 앱 실행중 5분마다 실행되거나, 특정 동작으로 실행되는 함수로 사용자의 정보와 주식의 정보를 업데이트 함
Future<void> reflashGetData(bool timeReFlash) async {
  final MyDataController myDataController = Get.find<MyDataController>();
  await myDataController.getUserData();
  await myDataController.getWalletData();

  // 주식 아이템 구매시에만 실행되는 함수
  if (!timeReFlash) {
    myDataController.setMoneyData();
    await myDataController.getTradeHistoryData();
  }
  await myDataController.updateMyTotalMoney();
}
