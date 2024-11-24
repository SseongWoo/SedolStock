import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import '../data/youtube_data.dart';

// 토큰을 안전하게 저장하기 위한 보안 저장소
const storage = FlutterSecureStorage();

// FlutterSecureStorage보다 더 큰 용량의 데이터를 기기에 저장하기 위한 라이브러리
final GetStorage box = GetStorage();

// 보안 저장소에 토큰을 저장하는 함수
Future<void> setTokens(String accessToken, String refreshToken, String uid) async {
  try {
    await storage.write(key: 'accessToken', value: accessToken);
    await storage.write(key: 'refreshToken', value: refreshToken);
    await storage.write(key: 'uid', value: uid);
  } catch (e) {
    print('Error saving tokens: $e');
  }
}

Future<void> setIdToken(String idToken) async {
  try {
    await storage.write(key: 'idToken', value: idToken);
  } catch (e) {
    print('Error saving idToken: $e');
  }
}

Future<void> setAccessToken(String accessToken) async {
  try {
    await storage.write(key: 'accessToken', value: accessToken);
  } catch (e) {
    print('Error saving accessToken: $e');
  }
}

Future<void> setUid(String uid) async {
  try {
    await storage.write(key: 'uid', value: uid);
  } catch (e) {
    print('Error saving UID: $e');
  }
}

// refreshToken을 보안 저장소에서 읽어오는 함수
Future<String?> getIdToken() async {
  try {
    return await storage.read(key: 'idToken');
  } catch (e) {
    print('Error reading idToken: $e');
    return null;
  }
}

Future<String?> getAccessToken() async {
  try {
    return await storage.read(key: 'accessToken');
  } catch (e) {
    print('Error reading accessToken: $e');
    return null;
  }
}

Future<String?> getRefreshToken() async {
  try {
    return await storage.read(key: 'refreshToken');
  } catch (e) {
    print('Error reading refreshToken: $e');
    return null;
  }
}

Future<String?> getUID() async {
  try {
    return await storage.read(key: 'uid');
  } catch (e) {
    print('Error reading UID: $e');
    return null;
  }
}

// 보안 저장소에서 모든 데이터를 삭제하는 함수
Future<void> clearTokens() async {
  try {
    await storage.deleteAll();
  } catch (e) {
    print('Error clearing tokens: $e');
  }
}

Future<void> deleteIDPW() async {
  try {
    await storage.delete(key: 'id');
    await storage.delete(key: 'pw');
  } catch (e) {
    print('Error deleting ID and PW: $e');
  }
}

Future<void> setDataDate(String date) async {
  try {
    await storage.write(key: 'data_date', value: date);
  } catch (e) {
    print('Error saving data date: $e');
  }
}

Future<String?> getDataDate() async {
  try {
    return await storage.read(key: 'data_date');
  } catch (e) {
    print('Error reading data date: $e');
    return null;
  }
}

void saveData(String key, dynamic value) {
  try {
    box.write(key, value);
  } catch (e) {
    print('Error saving data: $e');
  }
}

dynamic readData(String key) {
  try {
    return box.read(key);
  } catch (e) {
    print('Error reading data: $e');
    return null;
  }
}

void saveLatestYoutubeData() {
  try {
    final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
    final jsonData =
        youtubeDataController.latestYoutubeData.map((key, value) => MapEntry(key, value.toJson()));
    box.write('latestYoutubeData', jsonEncode(jsonData));
  } catch (e) {
    print('Error saving latest YouTube data: $e');
  }
}

Future<void> loadLatestYoutubeData() async {
  try {
    final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
    final jsonData = await box.read('latestYoutubeData');
    if (jsonData != null) {
      final Map<String, dynamic> dataMap = jsonDecode(jsonData);
      youtubeDataController.latestYoutubeData.assignAll(
        dataMap.map((key, value) => MapEntry(key, HomeYoutubeDataClass.fromJson(value))),
      );
    }
  } catch (e) {
    print('Error loading latest YouTube data: $e');
  }
}

void saveYoutubeChannelData() {
  try {
    final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
    final jsonData =
        youtubeDataController.youtubeChannelData.map((key, value) => MapEntry(key, value.toJson()));
    box.write('youtubeChannelData', jsonEncode(jsonData));
  } catch (e) {
    print('Error saving YouTube channel data: $e');
  }
}

Future<void> loadYoutubeChannelData() async {
  try {
    final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
    final jsonData = await box.read('youtubeChannelData');
    if (jsonData != null) {
      final Map<String, dynamic> dataMap = jsonDecode(jsonData);
      youtubeDataController.youtubeChannelData.assignAll(
        dataMap.map((key, value) => MapEntry(key, YoutubeChannelDataClass.fromJson(value))),
      );
    }
  } catch (e) {
    print('Error loading YouTube channel data: $e');
  }
}

void saveYoutubeVideoData() {
  try {
    final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
    final jsonData = youtubeDataController.youtubeVideoData
        .map((key, value) => MapEntry(key, value.map((video) => video.toJson()).toList()));
    box.write('youtubeVideoData', jsonEncode(jsonData));
  } catch (e) {
    print('Error saving YouTube video data: $e');
  }
}

Future<void> loadYoutubeVideoData() async {
  try {
    final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
    final jsonData = await box.read('youtubeVideoData');
    if (jsonData != null) {
      final Map<String, dynamic> dataMap = jsonDecode(jsonData);
      youtubeDataController.youtubeVideoData.assignAll(
        dataMap.map(
          (key, value) => MapEntry(
            key,
            List<YoutubeVideoDataClass>.from(
                value.map((video) => YoutubeVideoDataClass.fromJson(video))),
          ),
        ),
      );
    }
  } catch (e) {
    print('Error loading YouTube video data: $e');
  }
}

void saveRankingData() {
  try {
    final PublicDataController publicDataController = Get.find<PublicDataController>();
    final jsonData = publicDataController.rankingList.map((data) => data.toJson()).toList();
    box.write('rankingData', jsonEncode(jsonData));
  } catch (e) {
    print('Error saving ranking data: $e');
  }
}

Future<void> loadRankingData() async {
  try {
    final PublicDataController publicDataController = Get.find<PublicDataController>();
    final jsonData = await box.read('rankingData');
    if (jsonData != null) {
      final List<dynamic> dataList = jsonDecode(jsonData);
      publicDataController.rankingList.assignAll(
        dataList.map((data) => RankingDataClass.fromJson(data)).toList(),
      );
    }
  } catch (e) {
    print('Error loading ranking data: $e');
  }
}
