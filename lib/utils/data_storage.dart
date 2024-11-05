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
  await storage.write(key: 'accessToken', value: accessToken);
  await storage.write(key: 'refreshToken', value: refreshToken);
  await storage.write(key: 'uid', value: uid);
}

Future<void> setIdToken(String idTiken) async {
  await storage.write(key: 'idTiken', value: idTiken);
}

Future<void> setAccessToken(String accessToken) async {
  await storage.write(key: 'accessToken', value: accessToken);
}

Future<void> setUid(String uid) async {
  await storage.write(key: 'uid', value: uid);
}

// refreshToken을 보안 저장소에서 읽어오는 함수
Future<String?> getIdToken() async {
  return await storage.read(key: 'idToken');
}

// accessToken을 보안 저장소에서 읽어오는 함수
Future<String?> getAccessToken() async {
  return await storage.read(key: 'accessToken');
}

// refreshToken을 보안 저장소에서 읽어오는 함수
Future<String?> getRefreshToken() async {
  return await storage.read(key: 'refreshToken');
}

// accessToken을 보안 저장소에서 읽어오는 함수
Future<String?> getUID() async {
  return await storage.read(key: 'uid');
}

// 보안 저장소에서 모든 데이터를 삭제하는 함수
Future<void> clearTokens() async {
  await storage.deleteAll();
}

// 보안 저장소에 토큰을 저장하는 함수
Future<void> setIDPW(String id, String pw) async {
  await storage.write(key: 'id', value: id);
  await storage.write(key: 'pw', value: pw);
}

// 보안 저장소에 토큰을 저장하는 함수
Future<Map<String, String>> getIDPW() async {
  String id = '', pw = '';
  id = (await storage.read(key: 'id'))!;
  pw = (await storage.read(key: 'pw'))!;

  return {'id': id, 'pw': pw};
}

Future<void> deleteIDPW() async {
  await storage.delete(key: 'id');
  await storage.delete(key: 'pw');
}

Future<void> setDataDate(String date) async {
  await storage.write(key: 'data_date', value: date);
}

Future<String?> getDataDate() async {
  return await storage.read(key: 'data_date');
}

void saveData(String key, dynamic value) {
  box.write(key, value);
}

dynamic readData(String key) {
  return box.read(key);
}

void saveLatestYoutubeData() {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final jsonData =
      youtubeDataController.latestYoutubeData.map((key, value) => MapEntry(key, value.toJson()));
  box.write('latestYoutubeData', jsonEncode(jsonData));
}

Future<void> loadLatestYoutubeData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final jsonData = await box.read('latestYoutubeData'); // 비동기로 데이터 읽기
  if (jsonData != null) {
    final Map<String, dynamic> dataMap = jsonDecode(jsonData);
    youtubeDataController.latestYoutubeData.assignAll(
      dataMap.map((key, value) => MapEntry(key, HomeYoutubeDataClass.fromJson(value))),
    );
  }
}

void saveYoutubeChannelData() {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  // 데이터를 JSON 문자열로 변환하여 저장
  final jsonData =
      youtubeDataController.youtubeChannelData.map((key, value) => MapEntry(key, value.toJson()));
  box.write('youtubeChannelData', jsonEncode(jsonData));
}

// 불러오기 메서드
Future<void> loadYoutubeChannelData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final jsonData = await box.read('youtubeChannelData'); // 비동기적으로 데이터 읽기
  if (jsonData != null) {
    final Map<String, dynamic> dataMap = jsonDecode(jsonData);
    youtubeDataController.youtubeChannelData.assignAll(
      dataMap.map((key, value) => MapEntry(key, YoutubeChannelDataClass.fromJson(value))),
    );
  }
}

void saveYoutubeVideoData() {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  // JSON 형태로 변환하여 저장
  final jsonData = youtubeDataController.youtubeVideoData
      .map((key, value) => MapEntry(key, value.map((video) => video.toJson()).toList()));
  box.write('youtubeVideoData', jsonEncode(jsonData));
}

// 불러오기 메서드
Future<void> loadYoutubeVideoData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final jsonData = await box.read('youtubeVideoData'); // 비동기로 변경
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
}

void saveRankingData() {
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  // JSON 형태로 변환하여 저장
  final jsonData = publicDataController.rankingList.map((data) => data.toJson()).toList();
  box.write('rankingData', jsonEncode(jsonData));
}

// 불러오기 메서드
Future<void> loadRankingData() async {
  final PublicDataController publicDataController = Get.find<PublicDataController>();
  final jsonData = await box.read('rankingData');
  if (jsonData != null) {
    final List<dynamic> dataList = jsonDecode(jsonData);
    publicDataController.rankingList.assignAll(
      dataList.map((data) => RankingDataClass.fromJson(data)).toList(),
    );
  }
}
