import '../../main.dart';
import '../../service/http_service.dart';

class NameModel {
  final HttpService httpService = HttpService();

  // 이름 검색 함수
  Future<bool> searchName(String name) async {
    try {
      final response = await httpService.getRequest(
        '/names/$name',
      );

      if (response.statusCode == 200) {
        return true; // 이름이 존재
      } else if (response.statusCode == 404) {
        return false; // 이름이 없음
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('searchName error: $e');
    }
  }
}
