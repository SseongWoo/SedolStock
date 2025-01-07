import 'dart:convert';
import '../../main.dart';
import '../../service/http_service.dart';
import '../../service/storage_service.dart';
import '../../utils/date_time.dart';

// 회원가입 부분 모델
class SignupModel {
  String uid = '', refreshToken = '';
  final HttpService httpService = HttpService();

  // 유저 데이터 등록 기능
  Future<bool> signup(String email, String password) async {
    Map<String, dynamic>? jsonData;
    try {
      final response = await httpService.postRequest('signup', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 201) {
        logger.i('Signup successful');
        jsonData = jsonDecode(response.body);
        uid = jsonData!['user']['uid'];
        refreshToken = jsonData['user']['stsTokenManager']['refreshToken'];
        return true;
      } else {
        throw Exception(
            'Signup failed with status: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      logger.e('Signup error: $e');
      return false;
    }
  }

  // 닉네임 중복 탐색 기능
  Future<bool> searchName(String name) async {
    try {
      final response = await httpService.postRequest('/names/$name', {});

      if (response.statusCode == 200) {
        logger.i('searchName successful: ${response.body}');
        return true;
      } else if (response.statusCode == 404) {
        return false; // 중복된 닉네임이 없음
      } else {
        logger.w('searchName failed with status: ${response.statusCode}');
        return true;
      }
    } catch (e) {
      logger.e('searchName error: $e');
      return true;
    }
  }

  // 유저 데이터 등록 기능
  Future<bool> signupUserData(String id, String name, String choicechannel) async {
    try {
      final response = await httpService.postRequest('/signup/users', {
        'uid': uid,
        'id': id,
        'firstlogintime': formatDateTime(DateTime.now()),
        'name': name,
        'choicechannel': choicechannel
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('signupUserData error : ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      return false;
    }
  }

  // 유저 삭제 기능
  Future<bool> deleteUser() async {
    try {
      final response = await httpService.deleteRequest('users/$uid', {});

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete user: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      return false;
    }
  }

  // 이메일 전송 기능
  Future<bool> sendEmail(String id, String password) async {
    try {
      final response = await httpService.postRequest('/users/sendemail', {
        'email': id,
        'password': password,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('sendEmail error : ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      return false;
    }
  }

  // 이메일 인증 확인 기능
  Future<bool> checkEmail(String id) async {
    Map<String, dynamic>? jsonData;
    bool emailCheck;
    try {
      final response = await httpService.postRequest('/users/checkemail', {
        'uid': uid,
      });

      if (response.statusCode == 200) {
        jsonData = jsonDecode(response.body);
        emailCheck = jsonData!['emailVerified'];
        return emailCheck;
      } else {
        throw Exception('checkEmail error : ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      return false;
    }
  }

  void saveUserData() async {
    await setTokens(refreshToken, uid);
  }

  void setUid(String uid) {
    this.uid = uid;
  }
}
