import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stockpj/constants/route_constants.dart';
import '../constants/data_constants.dart';
import '../main.dart';
import '../model/data/data_class.dart';
import '../model/data/data_model.dart';
import '../service/storage_service.dart';
import '../utils/timer.dart';

// 팬덤명 맵 데이터
final Map<String, String> fanImageMap = Map.fromIterables(fanNameList, fanEnNameList);

final Map<String, int> streamerIndexMap = {
  for (int i = 0; i < fanNameList.length; i++) fanNameList[i]: i
};

class PublicDataController extends GetxController {
  final DataModel dataModel = DataModel();
  RxString appVersion = ''.obs; // 앱 버전
  RxString appBuild = ''.obs; // 앱 버전
  RxString storeVersion = ''.obs; // 스토어 최신 버전
  RxString storeBuild = ''.obs; // 스토어 최신 버전
  RxList<RankingDataClass> rankingList = <RankingDataClass>[].obs; // 랭킹 데이터 리스트
  RxString updateDate = ''.obs; // 랭킹 업데이트 날짜

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

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
      List<RankingDataClass> fetchedRankingList = await dataModel.fetchRankingData();
      rankingList.assignAll(fetchedRankingList);
      updateDate.value = DateTime.now().toString(); // 예제용 업데이트 날짜 설정
    } catch (e) {
      logger.e('getRankData error : $e');
    }
  }
}
