import 'dart:convert';
import '../../../main.dart';
import '../../../service/http_service.dart';
import 'data_class.dart';

class DataModel {
  final HttpService httpService = HttpService();

  // 유저 데이터
  Future<Map<String, dynamic>?> fetchUserData(String uid) async {
    try {
      final response = await httpService.getRequest('/users/$uid');
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
      } else if (response.statusCode == 404) {
        logger.w('User not found: $uid');
        return null;
      } else {
        logger.e('Server error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      logger.e('fetchUserData error: $e');
      return null;
    }
  }

  // 지갑 데이터
  Future<Map<String, dynamic>?> fetchWalletData(String uid) async {
    final response = await httpService.getRequest('/users/wallet/$uid');
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return {
        'data': jsonData['data'],
        'moneyHistory': jsonData['moneyhistory'],
      };
    } else {
      return null;
    }
  }

  // 거래 내역 리스트 데이터
  Future<List<TradeHistoryClass>?> fetchTradeHistory(String uid) async {
    final response = await httpService.getRequest('/users/tradeList/$uid');

    if (response.statusCode == 200 || response.statusCode == 404) {
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 404) {
        final jsonData = jsonDecode(response.body);

        if (jsonData is Map<String, dynamic>) {
          List<TradeHistoryClass> tradeHistoryList = [];

          for (int i = 0; i < (jsonData['itemuid'] as List).length; i++) {
            tradeHistoryList.add(TradeHistoryClass.fromJson(jsonData, i));
          }
          return tradeHistoryList;
        } else {
          throw Exception('Data length mismatch between lists.');
        }
      } else {
        throw Exception('Unexpected data format: $jsonData');
      }
    } else {
      throw Exception('Failed to fetch trade history. Status code: ${response.statusCode}');
    }
  }

  // 사용자의 총 자산을 서버에 업데이트하는 함수
  Future<bool> updateTotalMoney(
      String uid, int totalMoney, String fandom, String name, int level, bool administrator) async {
    final response = await httpService.putRequest('/users/updatetotalmoney/$uid', {
      'totalmoney': totalMoney,
      'fandom': fandom,
      'name': name,
      'level': level,
      'administrator': administrator,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update total money. Status code: ${response.statusCode}');
    }
  }

  // 서버에서 메시지 데이터를 가져오는 함수
  Future<List<MessageClass>> fetchMessages(String uid) async {
    final response = await httpService.getRequest('/users/message/$uid');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['messages'];
      return jsonData.map((data) => MessageClass.fromJson(data)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to fetch messages. Status code: ${response.statusCode}');
    }
  }

  // 서버에서 랭킹 데이터를 가져오는 함수
  Future<Map<String, dynamic>> fetchRankingData() async {
    try {
      final response = await httpService.getRequest('/rank/get');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // updatedate 가져오기
        final String updatedDate = jsonData['updatedate'] ?? '';

        // 랭킹 데이터를 그룹별로 변환
        final Map<String, List<RankingDataClass>> rankingData =
            (jsonData['ranking'] as Map<String, dynamic>).map(
          (key, value) {
            final List<dynamic> dataList = value ?? [];
            final rankingList = dataList.map((data) => RankingDataClass.fromJson(data)).toList();
            return MapEntry(key, rankingList);
          },
        );

        // updatedate와 랭킹 데이터를 포함한 결과 반환
        return {
          'updatedate': updatedDate,
          'ranking': rankingData,
        };
      } else {
        throw Exception('Failed to fetch ranking data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('fetchRankingData error: $e');
    }
  }

  // 서버에서 최신 영상들을 가져오는 함수
  Future<Map<String, YoutubeVideoDataClass>> fetchLatestYoutubeData() async {
    try {
      final response = await httpService.getRequest('/youtube/getLatestVideoInfo');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['videos'];

        // 데이터를 맵으로 변환
        return data.map((channelId, videoData) {
          return MapEntry(
            channelId,
            YoutubeVideoDataClass(
              title: videoData['title'] ?? '',
              thumbnail: videoData['thumbnail'] ?? '',
              publishedAt: videoData['publishedAt'] ?? '',
              videoUrl: videoData['videoUrl'] ?? '',
              channelName: videoData['channelName'] ?? '',
            ),
          );
        });
      } else {
        logger.w(
            'fetchLatestYoutubeData log : Failed to fetch latest videos. Status code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      logger.e('fetchLatestYoutubeData error : $e');
      return {};
    }
  }

// 서버에서 채널 정보들을 가져오는 함수
  Future<Map<String, YoutubeChannelDataClass>> fetchYoutubeChannelData() async {
    try {
      final response = await httpService.getRequest('/youtube/getchannelinfo');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['channel'];
        final Map<String, YoutubeChannelDataClass> channelDataMap = {};

        data.forEach((channelId, videoData) {
          channelDataMap[channelId] = YoutubeChannelDataClass(
            videoData['title'] ?? '',
            videoData['thumbnails'] ?? '',
            videoData['birthday'] ?? '',
            videoData['description'] ?? '',
            videoData['subscribercount'] ?? '',
          );
        });

        return channelDataMap;
      } else {
        throw Exception(
            'Failed to fetch YouTube channel data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('fetchYoutubeChannelData error: $e');
    }
  }

  // 서버에서 아이템 가격과 정보를 가져오는 함수
  Future<Map<String, dynamic>> fetchYoutubeLiveData() async {
    try {
      final response = await httpService.getRequest('/youtube/getlivedata');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch YouTube Live Data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('fetchYoutubeLiveData error: $e');
    }
  }

  // 서버에서 채널의 비디오 데이터를 가져오는 함수
  Future<Map<String, List<YoutubeVideoDataClass>>> fetchYoutubeVideoData() async {
    try {
      final response = await httpService.getRequest('/youtube/getvideodata');

      if (response.statusCode == 200) {
        final Map<String, dynamic> countMapData = jsonDecode(response.body)['channel'];
        final Map<String, List<YoutubeVideoDataClass>> youtubeVideoDataMap = {};

        countMapData.forEach((channelId, videoListData) {
          List<YoutubeVideoDataClass> videoList = (videoListData as List<dynamic>)
              .map((videoData) =>
                  YoutubeVideoDataClass.fromJson(Map<String, dynamic>.from(videoData)))
              .toList();

          youtubeVideoDataMap[channelId] = videoList;
        });

        logger.i('fetchYoutubeVideoData log : Youtube Video Data fetched successfully.');
        return youtubeVideoDataMap;
      } else {
        throw Exception('Failed to fetch Youtube Video Data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('fetchYoutubeVideoData error: $e');
    }
  }

  // 서버의 상수 데이터를 가져오는 함수
  Future<Map<String, dynamic>> fetchConstantsData() async {
    final response = await httpService.getRequest('/config');

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data']; // 'data' 추출
        return data;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fetch constants data error: $e');
    }
  }

  // 이벤트 데이터를 가져오는 함수
  Future<Map<String, dynamic>?> fetchEventData() async {
    final response = await httpService.getRequest('/event');

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data']; // 'data' 추출
        return data;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fetch constants data error: $e');
    }
  }

  // 이벤트 데이터를 가져오는 함수
  Future<Map<String, dynamic>> fetchServerData() async {
    final response = await httpService.getRequest('/server/data');

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        return decodedData;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fetch constants data error: $e');
    }
  }
}
