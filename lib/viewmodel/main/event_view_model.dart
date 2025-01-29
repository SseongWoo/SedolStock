import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import '../../data/my_data.dart';
import '../../data/youtube_data.dart';
import '../../utils/format.dart';
import '../../utils/screen_size.dart';
import 'package:flutter/material.dart';

// 이벤트 뷰모델
class EventViewModel extends GetxController {
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final ScreenController screenController = Get.find<ScreenController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  List<String> eventStatusList = ["예정된", "진행중인", "종료된"];

  // 채널 이름 설정
  Widget channelText(List<String> channelList) {
    int length = channelList.length;

    // 모든 채널인지 확인
    if (length >= _youtubeDataController.totalChannelIdList.length) {
      return const Text('모든 채널');
    }

    // 모든 메인채널인지 확인
    else if (length >= _youtubeDataController.channelIdList.length &&
        _areListsEqual(channelList, _youtubeDataController.channelIdList)) {
      return const Text('모든 메인채널');
    }

    // 모든 서브채널인지 확인
    else if (length >= _youtubeDataController.subChannelIdList.length &&
        _areListsEqual(channelList, _youtubeDataController.subChannelIdList)) {
      return const Text('모든 서브채널');
    }

    // 모든 조건에 해당이 안될 경우
    return Wrap(
      spacing: screenController.screenSize.value.getWidthPerSize(1),
      children: channelList.map((channel) {
        final channelData = _youtubeDataController.youtubeChannelData[channel];
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: screenController.screenSize.value.getHeightPerSize(1.5),
              backgroundImage: NetworkImage(
                channelData?.thumbnail ?? '', // 썸네일 URL
              ),
              onBackgroundImageError: (_, __) {
                Image.asset('assets/image/image_error.png');
              },
            ),
            SizedBox(width: screenController.screenSize.value.getWidthPerSize(1)),
            SizedBox(
              child: Text(
                truncateText(channelData?.title ?? '알 수 없음', 12),
                style: TextStyle(
                  fontSize: screenController.screenSize.value.getHeightPerSize(1.5),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

// 공통 리스트 비교 함수
  bool _areListsEqual(List<String> list1, List<String> list2) {
    list1.sort();
    list2.sort();
    return listEquals(list1, list2);
  }
}
