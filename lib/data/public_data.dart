import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stockpj/constants/route_constants.dart';
import '../constants/data_constants.dart';
import '../main.dart';
import '../model/data/data_class.dart';
import '../model/data/data_model.dart';
import '../service/storage_service.dart';
import '../utils/date_time.dart';
import '../utils/timer.dart';

// 팬덤명 맵 데이터
final Map<String, String> fanImageMap = Map.fromIterables(fanNameList, fanEnNameList);

class PublicDataController extends GetxController {
  final DataModel dataModel = DataModel();
  RxString appVersion = ''.obs; // 앱 버전
  RxString appBuild = ''.obs; // 앱 버전
  RxString storeVersion = ''.obs; // 스토어 최신 버전
  RxString storeBuild = ''.obs; // 스토어 최신 버전
  RxMap<String, List<RankingDataClass>> rankingMap = <String, List<RankingDataClass>>{}.obs;
  RxString updateDate = ''.obs; // 랭킹 업데이트 날짜
  Rx<PercentConfig> percentConfig =
      PercentConfig(delistingTime: 0, firstPrice: 0, percentage: 0).obs;
  Rx<FeeConfig> feeConfig = FeeConfig(buyFeeRate: 0.0, sellFeeRate: 0.0).obs;
  RxString eventDate = ''.obs; // 이벤트 기준 날짜
  RxMap<String, List<EventClass>> eventMap = <String, List<EventClass>>{}.obs; // 이벤트 데이터
  RxMap<String, double> eventChannelList = <String, double>{}.obs; // 이벤트가 있는 채널 모음
  RxInt manualRefresh = 0.obs; // 수동 새로고침 카운트

  // 로그아웃 기능 함수
  void logOut() async {
    EasyLoading.show();

    await clearTokens();
    Get.delete<TimerController>();
    EasyLoading.dismiss();
    Get.offAllNamed(AppRoute.signin);
  }

  // 앱의 버전을 가져오는 작업
  Future<void> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
    appBuild.value = packageInfo.buildNumber;
    logger.i('appversion : ${packageInfo.version}+${packageInfo.buildNumber}');
  }

  // 서버에서 랭킹 데이터를 가져오는 함수
  Future<void> getRankData() async {
    try {
      final rankingData = await dataModel.fetchRankingData();
      final Map<String, List<RankingDataClass>> rankings = rankingData['ranking'];

      updateDate.value = formatDateString2(rankingData['updatedate']);
      rankingMap.value = rankings;
    } catch (e) {
      logger.e('getRankData error : $e');
    }
  }

  // 서버 상수파일 가져오는 함수
  Future<void> getConstantsData() async {
    try {
      final response = await dataModel.fetchConstantsData();

      // feeConfig와 percentConfig에 값 설정
      feeConfig.value = FeeConfig.fromJson(response);
      percentConfig.value = PercentConfig.fromJson(response);
    } catch (e) {
      logger.e('Error loading constants data: $e');
    }
  }

  // 이벤트 데이터 가져오는 함수
  Future<void> getEventData() async {
    try {
      final PublicDataController publicDataController = Get.find<PublicDataController>();
      final response = await dataModel.fetchEventData();

      if (response != null) {
        final ongoing = (response['ongoing'] as List).map((e) => EventClass.fromJson(e)).toList();
        final upcoming = (response['upcoming'] as List).map((e) => EventClass.fromJson(e)).toList();
        final completed =
            (response['completed'] as List).map((e) => EventClass.fromJson(e)).toList();

        // eventMap에 데이터 저장
        publicDataController.eventMap['ongoing'] = ongoing;
        publicDataController.eventMap['upcoming'] = upcoming;
        publicDataController.eventMap['completed'] = completed;
      }
    } catch (e) {
      logger.e('Error loading event data: $e');
    }
  }

  // 오늘의 이벤트가 있는지 확인해서 데이터를 정리하는 함수
  void setEventCheck() {
    final ongoingEvents = eventMap['ongoing'];

    if (ongoingEvents != null) {
      for (var item in ongoingEvents) {
        for (var channel in item.channel) {
          eventChannelList[channel] =
              ((eventChannelList[channel] == null || eventChannelList[channel]! < item.multiplier)
                  ? item.multiplier
                  : eventChannelList[channel])!;
        }
      }
    }
  }
}
