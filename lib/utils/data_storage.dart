import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/main.dart';
import '../data/youtube_data.dart';

// 토큰을 안전하게 저장하기 위한 보안 저장소
const storage = FlutterSecureStorage();

// FlutterSecureStorage보다 더 큰 용량의 데이터를 기기에 저장하기 위한 라이브러리
final GetStorage box = GetStorage();

// 보안 저장소에 토큰을 저장하는 함수
Future<void> setTokens(String refreshToken, String uid) async {
  try {
    await storage.write(key: 'refreshToken', value: refreshToken);
    await storage.write(key: 'uid', value: uid);
  } catch (e) {
    logger.e('setTokens error : $e');
  }
}

// 보안 저장소에 토큰을 저장하는 함수
Future<void> setIdToken(String idToken) async {
  try {
    await storage.write(key: 'idToken', value: idToken);
  } catch (e) {
    logger.e('setIdToken error : $e');
  }
}

// 보안 저장소에 사용자의 uid를 저장하는 함수
Future<void> setUid(String uid) async {
  try {
    await storage.write(key: 'uid', value: uid);
  } catch (e) {
    logger.e('setUid error : $e');
  }
}

// refreshToken을 보안 저장소에서 읽어오는 함수
Future<String?> getIdToken() async {
  try {
    return await storage.read(key: 'idToken');
  } catch (e) {
    logger.e('getIdToken error : $e');
    return null;
  }
}

// 리플래시 토큰을 보안저장소에서 읽어오는 함수
Future<String?> getRefreshToken() async {
  try {
    return await storage.read(key: 'refreshToken');
  } catch (e) {
    logger.e('getRefreshToken error : $e');
    return null;
  }
}

// 사용자의 uid를 보안저장소에서 읽어오는 함수
Future<String?> getUID() async {
  try {
    return await storage.read(key: 'uid');
  } catch (e) {
    logger.e('getUID error : $e');
    return null;
  }
}

// 보안 저장소에서 모든 데이터를 삭제하는 함수
Future<void> clearTokens() async {
  try {
    await storage.deleteAll();
  } catch (e) {
    logger.e('clearTokens error : $e');
  }
}

// 보안 저장소에서 id 데이터를 삭제하는 함수
Future<void> deleteID() async {
  try {
    await storage.delete(key: 'id');
  } catch (e) {
    logger.e('deleteID error : $e');
  }
}

// 날짜 데이터를 보안저장소에 저장하는 함수
Future<void> setDataDate(String date) async {
  try {
    await storage.write(key: 'data_date', value: date);
  } catch (e) {
    logger.e('setDataDate error : $e');
  }
}

// 보안저장소에서 날짜 데이터를 읽어오는 함수
Future<String?> getDataDate() async {
  try {
    return await storage.read(key: 'data_date');
  } catch (e) {
    logger.e('getDataDate error : $e');
    return null;
  }
}

// 기기에 데이터를 저장하는 함수
void saveData(String key, dynamic value) {
  try {
    box.write(key, value);
  } catch (e) {
    logger.e('saveData error : $e');
  }
}

// 기기에 저장된 데이터를 읽어오는 함수
dynamic readData(String key) {
  try {
    return box.read(key);
  } catch (e) {
    logger.e('readData error : $e');
    return null;
  }
}

// 최신 영상 리스트 데이터를 기기에 저장하는 함수
void saveLatestYoutubeData() {
  try {
    final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
    final jsonData =
        youtubeDataController.latestYoutubeData.map((key, value) => MapEntry(key, value.toJson()));
    box.write('latestYoutubeData', jsonEncode(jsonData));
  } catch (e) {
    logger.e('saveLatestYoutubeData error : $e');
  }
}

// 기기에 저장되어있는 최신 영상 리스트 데이터를 읽어오는 함수
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
    logger.e('loadLatestYoutubeData error : $e');
  }
}

// 채널 정보 리스트 데이터를 기기에 저장하는 함수
void saveYoutubeChannelData() {
  try {
    final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
    final jsonData =
        youtubeDataController.youtubeChannelData.map((key, value) => MapEntry(key, value.toJson()));
    box.write('youtubeChannelData', jsonEncode(jsonData));
  } catch (e) {
    logger.e('saveYoutubeChannelData error : $e');
  }
}

// 기기에 저장되어있는 채널 정보 리스트 데이터를 읽어오는 함수
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
    logger.e('loadYoutubeChannelData error : $e');
  }
}

// 각각의 채널의 최신10개 영상의 데이터 리스트를 기기에 저장하는 함수
void saveYoutubeVideoData() {
  try {
    final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
    final jsonData = youtubeDataController.youtubeVideoData
        .map((key, value) => MapEntry(key, value.map((video) => video.toJson()).toList()));
    box.write('youtubeVideoData', jsonEncode(jsonData));
  } catch (e) {
    logger.e('saveYoutubeVideoData error : $e');
  }
}

// 기기에 저장되어있는 각각의 채널의 최신10개 영상의 데이터 리스트를 읽어오는 함수
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
    logger.e('loadYoutubeVideoData error : $e');
  }
}

// 랭킹 데이터 리스트를 기기에 저장하는 함수
void saveRankingData() {
  try {
    final PublicDataController publicDataController = Get.find<PublicDataController>();
    final jsonData = publicDataController.rankingList.map((data) => data.toJson()).toList();
    box.write('rankingData', jsonEncode(jsonData));
  } catch (e) {
    logger.e('saveRankingData error : $e');
  }
}

// 기기에 저장되어있는 랭킹 데이터 리스트를 읽어오는 함수
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
    logger.e('loadRankingData error : $e');
  }
}
