import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import '../../data/my_data.dart';
import '../../data/youtube_data.dart';
import '../../utils/screen_size.dart';

class EventViewModel extends GetxController {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  List<String> eventStatusList = ["예정된", "진행중인", "종료된"];

  String channelText(List<String> channelList) {
    int length = channelList.length;

    // 모든 채널인지 확인
    if (length >= youtubeDataController.totalChannelIdList.length) {
      return '모든 채널';
    }

    // 모든 메인채널인지 확인
    else if (length >= youtubeDataController.channelIdList.length &&
        _areListsEqual(channelList, youtubeDataController.channelIdList)) {
      return '모든 메인채널';
    }

    // 모든 서브채널인지 확인
    else if (length >= youtubeDataController.subChannelIdList.length &&
        _areListsEqual(channelList, youtubeDataController.subChannelIdList)) {
      return '모든 서브채널';
    }

    // 개별 채널 이름 반환
    return channelList
        .map((channel) => youtubeDataController.youtubeChannelData[channel]?.title ?? '알 수 없음')
        .join(', ');
  }

// 공통 리스트 비교 함수
  bool _areListsEqual(List<String> list1, List<String> list2) {
    list1.sort();
    list2.sort();
    return listEquals(list1, list2);
  }
}
