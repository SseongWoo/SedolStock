import 'dart:convert';
import '../../service/http_service.dart';

class SigninDataClass {
  final String uid;
  final String token;
  final bool checkEmail;

  SigninDataClass({
    required this.uid,
    required this.token,
    required this.checkEmail,
  });

  factory SigninDataClass.fromJson(Map<String, dynamic> json) {
    return SigninDataClass(
      uid: json['user']['uid'] ?? '',
      token: json['user']['stsTokenManager']['refreshToken'] ?? '',
      checkEmail: json['state'] != 'checkemail',
    );
  }
}

class SigninModel {
  final HttpService httpService = HttpService();

  // 로그인
  Future<SigninDataClass> signin(String email, String password) async {
    try {
      final response = await httpService.postRequest('/signin', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        return SigninDataClass.fromJson(jsonData);
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('SigninModel Error: $e');
    }
  }
}
