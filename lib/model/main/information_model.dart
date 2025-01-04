import '../../main.dart';
import '../../service/http_service.dart';
import 'package:flutter/material.dart';

// 정보 화면 사용자 자산 변동 그래프를 위한 클래스
class MyMoneyChartClass {
  String name;
  int money;

  MyMoneyChartClass(this.name, this.money);
}

class RateConfigClass {
  double rate;
  Color rateColor;

  RateConfigClass(this.rate, this.rateColor);
}

// 정보 화면 사용자 자산 변동 그래프를 위한 클래스
class MoneyChartClass {
  String name;
  int money;

  MoneyChartClass(this.name, this.money);
}

class InformationModel {
  final HttpService httpService = HttpService();

  // 이름 업데이트 기능
  Future<bool> updateName(String myUid, String myName, String newName) async {
    try {
      final response = await httpService.putRequest('/names/update', {
        'uid': myUid,
        'name': myName,
        'newname': newName,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('error ${response.statusCode}');
      }
    } catch (e) {
      logger.e('updateName error : $e');
      return false;
    }
  }

  // 팬덤 업데이트 기능
  Future<bool> updateFandom(String myUid, String fandomName) async {
    try {
      final response = await httpService.putRequest('/fanname/update', {
        'uid': myUid,
        'name': fandomName,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('error ${response.statusCode}');
      }
    } catch (e) {
      logger.e('updateFandom error : $e');
      return false;
    }
  }

  // 비밀번호 변경 기능
  Future<bool> changePW(String email) async {
    try {
      final response = await httpService.postRequest('/users/reset', {'email': email});

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('error ${response.statusCode}');
      }
    } catch (e) {
      logger.e('changePW error : $e');
      return false;
    }
  }

  // 회원탈퇴 기능
  Future<bool> deleteUserData(String myUID, String myName) async {
    try {
      final response =
          await httpService.deleteRequest('/deleteUser', {'uid': myUID, 'name': myName});

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('error ${response.statusCode}');
      }
    } catch (e) {
      logger.e('deleteUserData error : $e');
      return false;
    }
  }

  // 계정 정보 초기화 함수(파산 신청)
  Future<bool> restartUserData(String uid) async {
    try {
      if (uid == '') {
        throw Exception('uid is empty');
      }
      final userData = await httpService.putRequest('/users/restart', {
        'uid': uid,
      });

      if (userData.statusCode == 201) {
        return true;
      } else {
        throw Exception(userData.statusCode);
      }
    } catch (e) {
      logger.e('restartUserData error : $e');
      return false;
    }
  }
}
