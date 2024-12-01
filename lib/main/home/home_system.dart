import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';

class HomeController extends GetxController {
  RxBool mainChannelList = true.obs; // 채널 리스트 변경 변수
  RxBool mainChannelVideoList = true.obs; // 채널 비디오 리스트 변경 변수

  // 채널 리스트 변경 함수
  List<String> getChannelList() {
    return mainChannelList.value ? channelIdList : subChannelIdList;
  }

  // 채널 비디오 리스트 변경 함수
  List<String> getVideoList() {
    return mainChannelVideoList.value ? channelIdList : subChannelIdList;
  }
}
