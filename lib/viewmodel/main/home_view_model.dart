import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import '../../constants/route_constants.dart';
import '../../data/my_data.dart';
import '../../data/youtube_data.dart';
import '../../service/http_service.dart';
import '../../utils/get_env.dart';
import '../../utils/screen_size.dart';

// 홈 뷰 모델
class HomeViewModel extends GetxController {
  final HttpService _httpService = HttpService();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final ScreenController screenController = Get.find<ScreenController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  RxBool mainChannelList = true.obs; // 채널 리스트 변경 변수
  RxBool mainChannelVideoList = true.obs; // 채널 비디오 리스트 변경 변수
  RxString currentVideoTitle = '메인'.obs;
  RxString currentChannelTitle = '메인'.obs;

  // 이벤트 화면 이동
  void goEvent() {
    Get.toNamed(AppRoute.event);
  }

  // 채널 리스트 변경 함수
  List<String> getChannelList() {
    return mainChannelList.value
        ? youtubeDataController.channelIdList
        : youtubeDataController.subChannelIdList;
  }

  // 채널 비디오 리스트 변경 함수
  List<String> getVideoList() {
    return mainChannelVideoList.value
        ? youtubeDataController.channelIdList
        : youtubeDataController.subChannelIdList;
  }

  // 영상 목록 메인, 서브 채널 전환 버튼
  void toggleVideoList() {
    mainChannelVideoList.value = !mainChannelVideoList.value;
    currentVideoTitle.value = mainChannelVideoList.value ? '메인' : '서브';
  }

  // 채널 목록 메인, 서브 채널 전환 버튼
  void toggleChannelList() {
    mainChannelList.value = !mainChannelList.value;
    currentChannelTitle.value = mainChannelList.value ? '메인' : '서브';
  }

  // 해당 비디오 영상의 유튜브로 이동하는 함수
  void goVideo(int index) {
    final video = getVideoList();
    _httpService.openUrl(youtubeDataController.latestYoutubeData[video[index]]!.videoUrl,
        '오류가 발생했습니다. 네트워크 연결을 확인하거나, 다시 시도해주세요.');
  }

  // 헤당 채널의 유튜브로 이동하는 함수
  void goChannel(int index) {
    final channelId = getChannelList()[index];
    _httpService.openUrl(
        'https://www.youtube.com/channel/$channelId', '채널 이동에 실패했습니다.\n다시 시도해 주세요');
  }

  // 네이머 카페로 이동하는 함수
  void goCafe() {
    _httpService.openUrl(cafeURL, '카페 이동에 실패했습니다.\n다시 시도해 주세요');
  }
}
