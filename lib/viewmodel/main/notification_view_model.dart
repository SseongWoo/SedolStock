import 'package:get/get.dart';
import 'package:stockpj/model/main/notification_model.dart';
import '../../data/my_data.dart';
import '../../data/youtube_data.dart';
import '../../utils/screen_size.dart';

// 알림화면 뷰 모델
class NotificationViewModel extends GetxController {
  final NotificationModel notificationModel = NotificationModel();
  final ScreenController screenController = Get.find<ScreenController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final MyDataController myDataController = Get.find<MyDataController>();

  // 메세지 내용 설정
  String convertMessage(String itemUID, int stockCount) {
    return '${_youtubeDataController.channelMapData[itemUID]} 주식이 상장폐지되어\n보유 중이던 $stockCount개의 주식이 삭제되었습니다.';
  }

  // 단일 메세지 삭제
  void deleteMessage(int index) {
    notificationModel.deleteMessage(
        myDataController.myUid.value, myDataController.messageList[index].time);
    myDataController.messageList.removeAt(index); // 버튼 클릭 시 해당 메시지 삭제
  }

  // 전체 메세지 삭제
  void clearMessage() {
    notificationModel.deleteAllMessage(myDataController.myUid.value);
    myDataController.messageList.clear();
  }
}
