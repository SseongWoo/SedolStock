import 'package:intl/intl.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:get/get.dart';
import '../service/storage_service.dart';
import '../viewmodel/main/trade/trade_detail_view_model.dart';
import 'my_data.dart';

// 하루에 한번만 실행되는 함수
Future<void> fetchDataAndSave(YoutubeDataController youtubeDataController, String today) async {
  await youtubeDataController.getLatestYoutubeData();
  saveLatestYoutubeData();
  await youtubeDataController.getYoutubeChannelData();
  saveYoutubeChannelData();
  await youtubeDataController.getYoutubeVideoData();
  saveYoutubeVideoData();
  await setDataDate(today);
}

// 앱을 실행할때 실행되는 함수
Future<void> startGetData() async {
  DateTime now = DateTime.now();

  // 데이터를 가져오는 시간이 데이터 갱신 시간일 경우 5초 기다린 후 데이터를 가져옴
  if (_checkRefreshTime(now)) {
    await Future.delayed(const Duration(seconds: 5));
  }

  final MyDataController myDataController = Get.find<MyDataController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  String? date = await getDataDate();
  String today = DateFormat('MM월 dd일 hh시').format(now);

  // 오늘 실행된 이력이 있으면 일부 데이터만 가져오고, 없으면 모든 데이터를 가져오도록 동작
  if (date == null || date != today) {
    await fetchDataAndSave(youtubeDataController, today);
  } else {
    await loadLatestYoutubeData();
    await loadYoutubeChannelData();
    await loadYoutubeVideoData();

    if (youtubeDataController.latestYoutubeData.isEmpty ||
        youtubeDataController.youtubeChannelData.isEmpty ||
        youtubeDataController.youtubeVideoData.isEmpty) {
      await fetchDataAndSave(youtubeDataController, today);
    }
  }

  // 랭킹데이터를 가져오는 기능
  bool checkRankData = await loadRankingData();
  if (checkRankData) {
    await publicDataController.getRankData();
    saveRankingData();
  }

  // 이벤트 데이터를 가져오는 기능
  bool checkEventData = await loadEventData();
  if (!checkEventData) {
    await publicDataController.getEventData();
    saveEventData();
  }
  publicDataController.setEventCheck();

  await publicDataController.getConstantsData(); // 서버 상수데이터 가져오는 기능
  await youtubeDataController.getYoutubeLiveData(); // 유튜브 가격 데이터 가져오는 함수
  myDataController.setMoneyData(); // 사용자의 자산 데이터 정리
  await myDataController.getTradeHistoryData(); // 사용자의 거래 리스트 데이터 가져오는 함수

  // 거래 상세 화면에 있을시 그래프데이터 정리
  if (Get.isRegistered<TradeDetailViewModel>()) {
    final TradeDetailViewModel tradeDetailViewModel = Get.find<TradeDetailViewModel>();
    tradeDetailViewModel.setChartData();
  }
  await myDataController.getMessage(); // 메세지 데이터 가져오는 함수

  // 수동 새로고침 횟수를 초기화
  publicDataController.manualRefresh.value = 0;
}

// 앱 실행중 5분마다 실행되거나, 특정 동작으로 실행되는 함수로 사용자의 정보와 주식의 정보를 업데이트 함
Future<void> reflashGetData(bool timeReFlash) async {
  DateTime now = DateTime.now();

  // 데이터를 가져오는 시간이 데이터 갱신 시간일 경우 5초 기다린 후 데이터를 가져옴
  if (_checkRefreshTime(now)) {
    await Future.delayed(const Duration(seconds: 5));
  }

  final MyDataController myDataController = Get.find<MyDataController>();
  await myDataController.getUserData();

  // 주식 아이템 구매시에만 실행되는 함수
  if (!timeReFlash) {
    myDataController.setMoneyData();
    await myDataController.getTradeHistoryData();
  }
  await myDataController.updateMyTotalMoney();
  await myDataController.getWalletData(); // 사용자 자산 데이터 가져오는 기능
}

bool _checkRefreshTime(DateTime dateTime) {
  return dateTime.minute % 5 == 0 && dateTime.second < 5;
}
