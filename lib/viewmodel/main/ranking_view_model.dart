import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:flutter/material.dart';
import 'package:stockpj/service/storage_service.dart';
import '../../constants/color_constants.dart';
import '../../constants/data_constants.dart';
import '../../data/my_data.dart';
import '../../data/youtube_data.dart';
import '../../model/data/data_class.dart';
import '../../utils/color.dart';
import '../../utils/date_time.dart';
import '../../utils/screen_size.dart';
import '../../utils/timer.dart';
import '../../view/main/ranking/ranking_screen.dart';
import '../../view/main/ranking/ranking_widget.dart';

// 랭킹 뷰 모델
class RankingViewModel extends GetxController {
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final TimerController timerController = Get.find<TimerController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  RxString selectCategoryLargeItem = '전체'.obs; // 대분류 선택 아이템
  RxString selectCategorySmallItem = '전체'.obs; // 소분류 선택 아이템
  List<String> categoryLargeList = ['전체', '팬덤']; // 대분류 아이템 리스트
  List<String> categorySmallList = ['전체']; // 소분류 아이템 리스트

  Rx<Color> backgroundColor = Colors.white.obs; // 배경색
  Rx<Color> textColor = Colors.black.obs; // 글자색

  // 대분류 카태고리 선택
  void selectCategortLarge(String filter) {
    selectCategoryLargeItem.value = filter;

    if (selectCategoryLargeItem.value == '전체') {
      categorySmallList = ['전체'];
      selectCategorySmallItem.value = '전체';
      backgroundColor.value = Colors.white;
    } else {
      categorySmallList = List.from(fanNameList);
      selectCategortSmall(myDataController.myChoicechannel.value);
    }

    Get.back(); // 다이얼로그 닫기
  }

  // 소분류 카테고리 선택
  void selectCategortSmall(String filter) {
    selectCategorySmallItem.value = filter;
    backgroundColor.value = fanColorMap[filter] ?? Colors.white;
    textColor.value = filter == '박쥐단' ? Colors.white : Colors.black;

    Get.back(); // 다이얼로그 닫기
  }

  // 카테고리 다이얼로그 호출
  void showCategoryDialog(bool large) {
    Get.dialog(
      transitionDuration: const Duration(milliseconds: 180),
      CategoryDialog(
        screenSize: screenController.screenSize.value,
        categoryList: large ? categoryLargeList : categorySmallList,
        selectCategory: (String newValue) {
          if (large) {
            selectCategortLarge(newValue);
          } else {
            selectCategortSmall(newValue);
          }
        },
        selectCategoryItem: large ? selectCategoryLargeItem : selectCategorySmallItem,
      ),
    );
  }

  // 랭킹 순위 색
  Color rankingColor(int ranking) {
    switch (ranking) {
      case 1:
        return const Color(0xFFFDC707);
      case 2:
        return const Color(0xFF9FA4AF);
      case 3:
        return const Color(0xFFD18345);
      default:
        return Colors.black;
    }
  }

  // 내 랭킹 위젯의 배경색 설정
  Color myRankingColor() {
    return fanColorMap[myDataController.myChoicechannel.value] ?? colorIfari;
  }

  // 내 랭킹 순위
  String myRankingChange() {
    if (selectCategorySmallItem.value == '전체') {
      return myDataController.myRank.value == 0 ? '-' : myDataController.myRank.string;
    } else if (selectCategorySmallItem == myDataController.myChoicechannel) {
      return myDataController.myFandomRank.value == 0 ? '-' : myDataController.myFandomRank.string;
    } else {
      return 'X';
    }
  }
}
