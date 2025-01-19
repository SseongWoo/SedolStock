import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/main.dart';
import '../data/youtube_data.dart';
import '../model/data/data_class.dart';
import '../utils/set_myRank.dart';

// 토큰을 안전하게 저장하기 위한 보안 저장소
const storage = FlutterSecureStorage();

// FlutterSecureStorage보다 더 큰 용량의 데이터를 기기에 저장하기 위한 라이브러리
final GetStorage box = GetStorage();

// 보안 저장소에 토큰을 저장하는 함수
Future<void> setTokens(String? refreshToken, String? uid) async {
  try {
    await storage.write(key: 'refreshToken', value: refreshToken);
    await storage.write(key: 'uid', value: uid);
  } catch (e) {
    logger.e('setTokens error : $e');
  }
}

// 보안 저장소에 토큰을 저장하는 함수
Future<void> setIdToken(String? idToken) async {
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
        dataMap.map((key, value) => MapEntry(key, YoutubeVideoDataClass.fromJson(value))),
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
    final MyDataController myDataController = Get.find<MyDataController>();

    final Map<String, dynamic> jsonData = publicDataController.rankingMap.map(
      (key, value) => MapEntry(
        key,
        value.map((data) => data.toJson()).toList(),
      ),
    );

    setMyRank(myDataController, publicDataController);

    // 내 랭킹 저장
    box.write('myRankingData', {
      'totalRanking': myDataController.myRank.value,
      'fandomRanking': myDataController.myFandomRank.value
    });

    // 데이터를 로컬 저장
    box.write('rankingData', jsonEncode(jsonData));
    box.write('rankingDataDate', publicDataController.updateDate.value);
  } catch (e) {
    logger.e('saveRankingData error : $e');
  }
}

// 기기에 저장되어있는 랭킹 데이터 리스트를 읽어오는 함수
Future<bool> loadRankingData() async {
  try {
    final PublicDataController publicDataController = Get.find<PublicDataController>();
    final MyDataController myDataController = Get.find<MyDataController>();
    final jsonData = await box.read('rankingData');
    final myRankingData = box.read('myRankingData');

    if (myRankingData != null) {
      myDataController.myRank.value = myRankingData['totalRanking'];
      myDataController.myFandomRank.value = myRankingData['fandomRanking'];
    }

    if (jsonData != null) {
      // JSON 데이터를 Map 형식으로 디코딩
      final Map<String, dynamic> decodedData = jsonDecode(jsonData);

      // 각 그룹의 데이터를 RankingDataClass로 변환하여 rankingMap에 할당
      publicDataController.rankingMap.value = decodedData.map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>)
              .map((data) => RankingDataClass.fromJson(Map<String, dynamic>.from(data)))
              .toList(),
        ),
      );
    }

    // 저장된 날짜 가져오기
    publicDataController.updateDate.value = await box.read('rankingDataDate');

    DateTime currentTime = DateTime.now();
    DateTime serverUpdateDate = DateFormat('yyyy년 MM.dd HH:mm')
        .parse('${currentTime.year}년 ${publicDataController.updateDate.value}');

    return currentTime.difference(serverUpdateDate).inHours >= 1;
  } catch (e) {
    logger.e('loadRankingData error : $e');
    return true;
  }
}

// 이벤트 데이터 저장 함수
void saveEventData() {
  try {
    final PublicDataController publicDataController = Get.find<PublicDataController>();

    final jsonData = publicDataController.eventMap.map(
      (key, value) => MapEntry(
        key,
        value.map((e) => e.toJson()).toList(),
      ),
    );

    box.write('eventDate', publicDataController.eventDate.value);
    box.write('event', jsonEncode(jsonData));

    logger.i('Event data saved successfully');
  } catch (e) {
    logger.e('saveEventData error: $e');
  }
}

// 기기에 저장되어있는 각각의 채널의 최신10개 영상의 데이터 리스트를 읽어오는 함수
Future<bool> loadEventData() async {
  try {
    final PublicDataController publicDataController = Get.find<PublicDataController>();
    final jsonData = await box.read('event');
    publicDataController.eventDate.value = await box.read('eventDate');

    if (jsonData != null) {
      final decodedData = jsonDecode(jsonData);

      publicDataController.eventMap['ongoing'] =
          (decodedData['ongoing'] as List).map((e) => EventClass.fromJson(e)).toList();
      publicDataController.eventMap['upcoming'] =
          (decodedData['upcoming'] as List).map((e) => EventClass.fromJson(e)).toList();
      publicDataController.eventMap['completed'] =
          (decodedData['completed'] as List).map((e) => EventClass.fromJson(e)).toList();
    }

    if (publicDataController.eventDate.value.isNotEmpty) {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      return publicDataController.eventDate.value == today;
    }
    return false;
  } catch (e) {
    logger.e('loadEventData error : $e');
    return false;
  }
}
