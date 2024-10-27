import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/information_system.dart';
import 'package:stockpj/main/trade/detail/trade_detail_system.dart';
import 'my_data.dart';

Future<void> startGetData() async {
  final MyDataController myDataController = Get.find<MyDataController>();
  await getLatestYoutubeData();
  await getYoutubeChannelData();
  await getYoutubeLiveData();
  await getYoutubeVideoData();
  myDataController.setMoneyData();
  await getTradeHistoryData();
  await getRankData();
}

Future<void> reflashGetData() async {
  final MyDataController myDataController = Get.find<MyDataController>();
  final TradeDetailController tradeDetailController = Get.find<TradeDetailController>();
  final InformationController informationController = Get.find<InformationController>();
  await getUserData();
  await getWalletData();
  myDataController.setMoneyData();
  tradeDetailController.setDetailData();
  await getTradeHistoryData();
  await updateMyTotalMoney();
  informationController.profitRate();
  informationController.setMoneyChartData();
}
