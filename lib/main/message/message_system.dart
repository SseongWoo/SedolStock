import 'package:get/get.dart';
import 'package:stockpj/data/youtube_data.dart';

import '../../data/my_data.dart';

class MessageController extends GetxController {
  final MyDataController _myDataController = Get.find<MyDataController>();
  String convertMessage(String itemUID, int stockCount) {
    List<String> parts = itemUID.split('_');

    return '${channelMapData[parts[0]]}(${parts[1] == 'view' ? '조회수' : '좋아요수'})주식이 상장폐지되어\n보유 중이던 $stockCount개의 주식이 삭제되었습니다.';
  }

  void clearMessage() {
    _myDataController.messageList.clear();
  }
}
