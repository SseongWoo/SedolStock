import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stockpj/utils/get_env.dart';
import '../constants/data_constants.dart';
import '../main.dart';
import '../model/data/data_class.dart';
import '../model/data/data_model.dart';
import '../model/main/trade_model.dart';
import '../utils/color.dart';

class YoutubeDataController extends GetxController {
  final DataModel dataModel = DataModel();
  List<String> totalChannelIdList = [];
  List<String> channelIdList = []; // 채널 uid 리스트 데이터
  List<String> subChannelIdList = []; // 서브채널 uid 리스트 데이터

  // 채널 UID와 이름으로 구성된 맵 데이터
  Map<String, String> channelMapData = {};

  // 채널 UID와 서브채널 UID로 구성된 맵 데이터
  //Map<String, String> subUidToMainUidMap = {};

  RxMap<String, YoutubeVideoDataClass> latestYoutubeData =
      <String, YoutubeVideoDataClass>{}.obs; // 직전 유튜브 데이터 맵 데이터
  RxMap<String, YoutubeChannelDataClass> youtubeChannelData =
      <String, YoutubeChannelDataClass>{}.obs; // 유튜브 채널 데이터 맵 데이터
  RxMap<String, List<SalesData>> youtubeChartData =
      <String, List<SalesData>>{}.obs; // 차트에 사용될 가격 데이터 맵 데이터
  RxMap<String, List<YoutubeVideoDataClass>> youtubeVideoData =
      <String, List<YoutubeVideoDataClass>>{}.obs; // 비디오 데이터 맵 데이터
  RxMap<String, ItemPriceDataClass> itemPriceDateMap =
      <String, ItemPriceDataClass>{}.obs; // 주식 종목들 데이터

  @override
  void onReady() {
    super.onReady();

    // 각각 전체, 메인, 서브 채널의 uid를 저장하는 리스트
    totalChannelIdList = getTotalChannelIdList();
    channelIdList = getChannelIdList();
    subChannelIdList = getSubChannelIdList();

    if (channelIdList.isNotEmpty && channelNameList.isNotEmpty) {
      channelMapData = Map.fromIterables(totalChannelIdList, channelNameList);
    }

    setStreamerColorMap();
  }

// 주식 아이템 상세페이지의 그래프에 사용될 데이터를 형식에 맞게 가공하여 저장하는 함수
  List<SalesData> convertViewCountToSalesData(List<int> viewCountList) {
    List<SalesData> salesDataList = [];

    // 현재 시간을 가져와 5분 단위로 내림 처리
    DateTime now = DateTime.now();
    DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, (now.minute ~/ 5) * 5);

    for (int i = viewCountList.length - 1; i >= 0; i--) {
      String formattedTime = DateFormat('HH:mm').format(currentTime);
      salesDataList.add(SalesData(formattedTime, viewCountList[i].toDouble()));
      currentTime = currentTime.subtract(const Duration(minutes: 5));
    }
    return salesDataList;
  }

// 주식 아이템 상세페이지의 그래프에 사용될 데이터를 형식에 맞게 가공하여 저장하는 함수
  List<FlSpot> convertViewCountToSalesDataTest(List<int> viewCountList) {
    List<FlSpot> salesDataList = [];

    // 현재 시간을 가져와 5분 단위로 내림 처리
    DateTime now = DateTime.now();
    DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, (now.minute ~/ 5) * 5);

    for (int i = viewCountList.length - 1; i >= 0; i--) {
      String formattedTime = DateFormat('HH:mm').format(currentTime);
      salesDataList.add(FlSpot(i.toDouble(), viewCountList[i].toDouble()));
      currentTime = currentTime.subtract(const Duration(minutes: 5));
    }
    return salesDataList;
  }

// 최신 유튜브 영상 데이터 가져오기
  Future<void> getLatestYoutubeData() async {
    final fetchedData = await dataModel.fetchLatestYoutubeData();

    if (fetchedData.isNotEmpty) {
      latestYoutubeData.assignAll(fetchedData);
      logger.i('getLatestYoutubeData log : Latest Videos stored successfully.');
    } else {
      logger.w('getLatestYoutubeData log : No data to store.');
    }
  }

// 채널 데이터 가져오기
  Future<void> getYoutubeChannelData() async {
    try {
      final channelData = await dataModel.fetchYoutubeChannelData();
      youtubeChannelData.assignAll(channelData);

      logger.i('getYoutubeChannelData log: YouTube Channel Data stored successfully.');
    } catch (e) {
      logger.e('getYoutubeChannelData error: $e');
    }
  }

  // 채널의 아이템 가격과 정보를 가져오는 함수
  Future<void> getYoutubeLiveData() async {
    try {
      final data = await dataModel.fetchYoutubeLiveData();

      final countMapData = data['countMapData'] as Map<String, dynamic>;
      final chartDataList = data['chartDataList'] as Map<String, dynamic>;

      // 아이템 가격 데이터 저장
      countMapData.forEach((channelId, videoData) {
        int diff = (videoData['price'] ?? 0) - (videoData['lastPrice'] ?? 0);
        double ratio = (diff / (videoData['lastPrice'] ?? 1)) * 100;
        String channelType = channelIdList.contains(channelId) ? 'main' : 'sub';

        itemPriceDateMap[channelId] = ItemPriceDataClass(
          channelId,
          channelType,
          videoData['price'] ?? 0,
          videoData['totalViewCount'] ?? 0,
          videoData['totalLikeCount'] ?? 0,
          videoData['lastTotalViewCount'] ?? 0,
          videoData['lastTotalLikeCount'] ?? 0,
          videoData['lastPrice'] ?? 0,
          diff,
          videoData['delisting'] ?? 0,
          videoData['continuous'] ?? 0,
          ratio,
        );
      });

      // 차트 데이터 저장
      chartDataList.forEach((channelId, videoData) {
        youtubeChartData[channelId] = convertViewCountToSalesData(
          (videoData['price'] as List<dynamic>?)?.map((e) {
                if (e is double) {
                  return e.round(); // double이면 반올림하여 int로 변환
                } else {
                  return int.tryParse(e.toString()) ?? 0; // 그 외 값은 int로 변환
                }
              }).toList() ??
              [0],
        );
      });
      logger.i('getYoutubeLiveData log: YouTube Live Data stored successfully.');
    } catch (e) {
      logger.e('getYoutubeLiveData error: $e');
    }
  }

  // 채널 비디오 데이터를 가져오는 함수
  Future<void> getYoutubeVideoData() async {
    try {
      final videoDataMap = await dataModel.fetchYoutubeVideoData();
      youtubeVideoData.assignAll(videoDataMap);
    } catch (e) {
      logger.e('getYoutubeVideoData error: $e');
    }
  }
}
