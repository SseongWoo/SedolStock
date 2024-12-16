import 'dart:convert';

import 'package:get/get.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:http/http.dart' as http;
import 'package:stockpj/main.dart';
import '../../data/my_data.dart';
import '../../utils/get_env.dart';

class MessageController extends GetxController {
  final MyDataController _myDataController = Get.find<MyDataController>();
  String convertMessage(String itemUID, int stockCount) {
    List<String> parts = itemUID.split('_');

    return '${channelMapData[parts[0]]}(${parts[1] == 'view' ? '조회수' : '좋아요수'})주식이 상장폐지되어\n보유 중이던 $stockCount개의 주식이 삭제되었습니다.';
  }

  void clearMessage() {
    deleteAllMessage(_myDataController.myUid.value);
    _myDataController.messageList.clear();
  }

  Future<void> deleteMessage(String messageUID) async {
    final apiUrl = '$httpURL/users/message/${_myDataController.myUid}';

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'messageUID': messageUID}),
      );

      if (response.statusCode == 200) {
        logger.i('Message deleted successfully');
      } else {
        logger.w('Failed to delete message');
      }
    } catch (e) {
      logger.e('deleteMessage error : $e');
    }
  }

  Future<void> deleteAllMessage(String uid) async {
    final apiUrl = '$httpURL/users/allmessage/${_myDataController.myUid}';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        logger.i('All messages deleted successfully');
      } else {
        logger.w('Failed to delete all messages');
      }
    } catch (e) {
      logger.e('deleteAllMessage error : $e');
    }
  }
}
