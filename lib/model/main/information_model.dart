import '../../main.dart';
import '../../service/http_service.dart';
import 'package:flutter/material.dart';

class RateConfigClass {
  double rate;
  Color rateColor;

  RateConfigClass(this.rate, this.rateColor);
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
  Future<bool> deleteUserData(String myUID, String myName, String myFandom) async {
    try {
      final response = await httpService
          .deleteRequest('/deleteUser', {'uid': myUID, 'name': myName, 'fandom': myFandom});

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
}
