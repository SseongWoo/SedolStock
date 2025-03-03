import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/model/data/data_class.dart';
import 'package:stockpj/model/main/notification_model.dart';
import 'package:stockpj/utils/format.dart';
import '../../data/my_data.dart';
import '../../data/youtube_data.dart';
import '../../utils/screen_size.dart';

// 알림화면 뷰 모델
class NotificationViewModel extends GetxController {
  final NotificationModel notificationModel = NotificationModel();
  final ScreenController screenController = Get.find<ScreenController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final MyDataController myDataController = Get.find<MyDataController>();

  String convertMessageTitle(MessageClass messageData) {
    switch (messageData.type) {
      case 'delisting':
        return '상장폐지 알림';
      case 'dividend_1' || 'dividend_2':
        return '배당금 알림';
      default:
        return '메세지 제목';
    }
  }

  // 메세지 내용 설정
  String convertMessageContent(MessageClass messageData) {
    switch (messageData.type) {
      case 'delisting':
        return '${_youtubeDataController.channelMapData[messageData.itemUID]} 주식이 상장폐지되어\n보유 중이던 ${formatToCurrency(messageData.number)}개의 주식이 삭제되었습니다.';
      case 'dividend_1' || 'dividend_2':
        return '보유 중인 ${_youtubeDataController.channelMapData[messageData.itemUID]} 주식에서\n배당금 ${formatToCurrency(messageData.number)}P가 지급되었습니다.';
      default:
        return '메세지 제목';
    }
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
