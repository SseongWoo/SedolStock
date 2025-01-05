import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import '../../data/my_data.dart';
import '../../data/youtube_data.dart';
import '../../utils/color.dart';
import '../../utils/date_time.dart';
import '../../utils/screen_size.dart';
import '../../utils/timer.dart';

// 랭킹 뷰 모델
class RankingViewModel extends GetxController {
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final TimerController timerController = Get.find<TimerController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  RxString timeText = ''.obs; // 랭킹 업데이트 시간 텍스트

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    timeText.value = '${formatDateString4(publicDataController.updateDate.value)} 01시 00분 기준';
  }

  // 내 랭킹 위젯의 배경색 설정
  Color myRankingColor() {
    return fanColorMap[myDataController.myChoicechannel.value] ?? colorIfari;
  }

  // 내 랭킹 순위
  String myRankingChange() {
    return myDataController.myRank.value == 0 ? '-' : myDataController.myRank.string;
  }

  // 랭킹 순위 크기
  double myRankingTextSize() {
    return myDataController.myRank < 100 ? 3 : 2;
  }
}
