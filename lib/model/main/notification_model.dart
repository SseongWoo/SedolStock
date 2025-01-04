import '../../main.dart';
import '../../service/http_service.dart';

class NotificationModel {
  final HttpService httpService = HttpService();
  // 단일 메세지 삭제
  Future<bool> deleteMessage(String myUID, String messageUID) async {
    try {
      final response =
          await httpService.deleteRequest('/users/message/$myUID', {'messageUID': messageUID});

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      logger.e('deleteMessage error : $e');
      return false;
    }
  }

  // 모든 메세지 삭제
  Future<bool> deleteAllMessage(String myUID) async {
    try {
      final response = await httpService.deleteRequest('/users/allmessage/$myUID', {});

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      logger.e('deleteAllMessage error : $e');
      return false;
    }
  }
}
