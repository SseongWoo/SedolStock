import 'dart:convert';
import '../service/http_service.dart';
import '../service/storage_service.dart';

class LoginDataClass {
  String uid;
  String token;

  LoginDataClass(this.uid, this.token);
}

class SplashModel {
  final HttpService httpService = HttpService();

  // 자동 로그인
  Future<LoginDataClass> tryAutoLogin() async {
    Map<String, dynamic>? jsonData;
    String? refreshToken = await getRefreshToken();
    String? idToken = await getIdToken();

    if (refreshToken == null) {
      throw Exception('Token is missing.');
    }

    final response = await httpService
        .postRequest('/signin/tokenlogin', {'idToken': idToken, "refreshToken": refreshToken});

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);

      return LoginDataClass(jsonData?['uid'], jsonData?['idToken']);
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      throw Exception('Invalid or expired token.');
    } else {
      throw Exception('Unexpected error during auto login.');
    }
  }
}
