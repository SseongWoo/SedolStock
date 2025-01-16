import 'package:flutter/material.dart';
import 'package:stockpj/data/youtube_data.dart';
import '../constants/color_constants.dart';
import '../constants/data_constants.dart';
import 'package:get/get.dart';

Map<String, Color> streamerColorMap = {}; // colorIfari 색상을 제외한 맵 리스트
Map<String, Color> fanColorMap = Map.fromIterables(fanNameList, colorList); // 팬덤명과 색상을 합친 맵 리스트

// streamerColorMap 맵 데이터의 값을 설정하는 함수
void setStreamerColorMap() {
  final YoutubeDataController youtubeVideoDataClass = Get.find<YoutubeDataController>();
  List<Color> filteredColors = List.from(channelColorList);
  streamerColorMap = Map.fromIterables(youtubeVideoDataClass.totalChannelIdList, filteredColors);
}

// 이득일경우 붉은색 손해일경우 푸른색 둘다 아닐경우 회색을 반환하는 함수
Color profitAndLossColor(num value) {
  return value > 0
      ? Colors.red
      : value < 0
          ? Colors.blue
          : Colors.grey;
}
