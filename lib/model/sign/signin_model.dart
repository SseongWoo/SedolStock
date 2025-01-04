import 'dart:convert';
import '../../service/http_service.dart';

class SigninDataClass {
  final String uid;
  final String token;
  final bool checkemail;

  SigninDataClass({
    required this.uid,
    required this.token,
    required this.checkemail,
  });
}

class SigninModel {
  final HttpService httpService = HttpService();

  // 로그인
  Future<SigninDataClass> signin(String email, String password) async {
    try {
      final response = await httpService.postRequest('signin', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);

        final uid = jsonData['user']['uid'] ?? '';
        final refreshToken = jsonData['user']['stsTokenManager']['refreshToken'] ?? '';
        final checkEmail = jsonData['state'] != 'checkemail';

        return SigninDataClass(
          uid: uid,
          token: refreshToken,
          checkemail: checkEmail,
        );
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('SigninModel Error: $e');
    }
  }
}
