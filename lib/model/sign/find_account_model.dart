import '../../main.dart';
import '../../service/http_service.dart';

class FindAccountModel {
  final HttpService httpService = HttpService();

  // 비밀번호 찾기 이메일 보내는 함수
  Future<bool> sendFindEmail(String email) async {
    try {
      final response = await httpService.postRequest('/signin', {'email': email});

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      logger.e('sendFindEmail error : $e');
      return false;
    }
  }
}
