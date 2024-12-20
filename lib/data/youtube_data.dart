import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:stockpj/data/public_data.dart';
import 'dart:convert';
import 'package:stockpj/utils/get_env.dart';
import '../main.dart';
import '../main/trade/detail/trade_detail_system.dart';

Map<String, String> channelMapData =
    Map.fromIterables(channelIdList, channelNameList); // 채널의 uid와 이름으로 구성된 맵 데이터
Map<String, String> channelAndSubChannelMapData =
    Map.fromIterables(channelIdList, subChannelIdList); // 채널의 uid와 서브채널의 uid로 구성되어있는 맵 데이터

// 홈 화면에 사용될 최신영상 데이터 클래스
class HomeYoutubeDataClass {
  String title;
  String thumbnail;
  String publishedAt;
  String videoUrl;
  String channelName;

  HomeYoutubeDataClass(
      this.title, this.thumbnail, this.publishedAt, this.videoUrl, this.channelName);

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() => {
        'title': title,
        'thumbnail': thumbnail,
        'publishedAt': publishedAt,
        'videoUrl': videoUrl,
        'channelName': channelName,
      };

  // JSON을 객체로 변환
  factory HomeYoutubeDataClass.fromJson(Map<String, dynamic> json) {
    return HomeYoutubeDataClass(
      json['title'],
      json['thumbnail'],
      json['publishedAt'],
      json['videoUrl'],
      json['channelName'],
    );
  }
}

// 유튜브 영상 데이터 클래스
class YoutubeVideoDataClass {
  String videoid;
  String title;
  String description;
  String thumbnailurl;
  String publishedat;

  YoutubeVideoDataClass(
    this.videoid,
    this.title,
    this.description,
    this.thumbnailurl,
    this.publishedat,
  );

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() => {
        'videoid': videoid,
        'title': title,
        'description': description,
        'thumbnailurl': thumbnailurl,
        'publishedat': publishedat,
      };

  // JSON을 객체로 변환
  factory YoutubeVideoDataClass.fromJson(Map<String, dynamic> json) {
    return YoutubeVideoDataClass(
      json['videoid'],
      json['title'],
      json['description'],
      json['thumbnailurl'],
      json['publishedat'],
    );
  }
}

// 채널의 데이터 클래스
class YoutubeChannelDataClass {
  String birthday;
  String description;
  String subscribercount;
  String thumbnail;
  String title;

  YoutubeChannelDataClass(
    this.title,
    this.thumbnail,
    this.birthday,
    this.description,
    this.subscribercount,
  );

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() => {
        'title': title,
        'thumbnail': thumbnail,
        'birthday': birthday,
        'description': description,
        'subscribercount': subscribercount,
      };

  // JSON을 객체로 변환
  factory YoutubeChannelDataClass.fromJson(Map<String, dynamic> json) {
    return YoutubeChannelDataClass(
      json['title'],
      json['thumbnail'],
      json['birthday'],
      json['description'],
      json['subscribercount'],
    );
  }
}

// 차트에 사용될 주식 데이터 리스트 클래스
class YoutubeChartDataClass {
  List<SalesData> commentCount;
  List<SalesData> likeCount;
  List<SalesData> viewCount;

  YoutubeChartDataClass(this.commentCount, this.likeCount, this.viewCount);
}

// 채널의 가격 데이터 클래스
class YoutubeLiveDataClass {
  int differenceCommentCount;
  int differenceLikeCount;
  int differenceViewCount;
  int lastDifferenceCommentCount;
  int lastDifferenceLikeCount;
  int lastDifferenceViewCount;
  int lastTotalCommentCount;
  int lastTotalLikeCount;
  int lastTotalViewCount;
  int totalCommentCount;
  int totalLikeCount;
  int totalViewCount;
  int lastCommentCountPrice;
  int lastViewCountPrice;
  int lastLikeCountPrice;
  int commentCountPrice;
  int likeCountPrice;
  int viewCountPrice;
  int viewDelisting;
  int likeDelisting;
  int commentDelisting;
  String updateTime;

  YoutubeLiveDataClass(
    this.differenceCommentCount,
    this.differenceLikeCount,
    this.differenceViewCount,
    this.lastDifferenceCommentCount,
    this.lastDifferenceLikeCount,
    this.lastDifferenceViewCount,
    this.lastTotalCommentCount,
    this.lastTotalLikeCount,
    this.lastTotalViewCount,
    this.totalCommentCount,
    this.totalLikeCount,
    this.totalViewCount,
    this.lastCommentCountPrice,
    this.lastViewCountPrice,
    this.lastLikeCountPrice,
    this.commentCountPrice,
    this.likeCountPrice,
    this.viewCountPrice,
    this.viewDelisting,
    this.likeDelisting,
    this.commentDelisting,
    this.updateTime,
  );
}

class YoutubeDataController extends GetxController {
  RxMap<String, HomeYoutubeDataClass> latestYoutubeData =
      <String, HomeYoutubeDataClass>{}.obs; // 직전 유튜브 데이터 맵 데이터
  RxMap<String, YoutubeChannelDataClass> youtubeChannelData =
      <String, YoutubeChannelDataClass>{}.obs; // 유튜브 채널 데이터 맵 데이터
  RxMap<String, YoutubeLiveDataClass> youtubeLiveData =
      <String, YoutubeLiveDataClass>{}.obs; // 유튜브 가격 데이터 맵 데이터
  RxMap<String, YoutubeChartDataClass> youtubeChartData =
      <String, YoutubeChartDataClass>{}.obs; // 차트에 사용될 가격 데이터 맵 데이터
  RxMap<String, List<YoutubeVideoDataClass>> youtubeVideoData =
      <String, List<YoutubeVideoDataClass>>{}.obs; // 비디오 데이터 맵 데이터
}

// 주식 아이템 상세페이지의 그래프에 사용될 데이터를 형식에 맞게 가공하여 저장하는 함수
List<SalesData> convertViewCountToSalesData(List<int> viewCountList) {
  List<SalesData> salesDataList = [];

  // 현재 시간을 가져와 5분 단위로 내림 처리
  DateTime now = DateTime.now();
  DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, (now.minute ~/ 5) * 5);

  for (int i = viewCountList.length - 1; i >= 0; i--) {
    String formattedTime = DateFormat('HH:mm').format(currentTime);
    salesDataList.add(SalesData(formattedTime, viewCountList[i].toDouble()));
    currentTime = currentTime.subtract(const Duration(minutes: 5));
  }
  return salesDataList;
}

// 주식 아이템 상세페이지의 그래프에 사용될 데이터를 형식에 맞게 가공하여 저장하는 함수
List<FlSpot> convertViewCountToSalesDataTest(List<int> viewCountList) {
  List<FlSpot> salesDataList = [];

  // 현재 시간을 가져와 5분 단위로 내림 처리
  DateTime now = DateTime.now();
  DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, (now.minute ~/ 5) * 5);

  for (int i = viewCountList.length - 1; i >= 0; i--) {
    String formattedTime = DateFormat('HH:mm').format(currentTime);
    salesDataList.add(FlSpot(i.toDouble(), viewCountList[i].toDouble()));
    currentTime = currentTime.subtract(const Duration(minutes: 5));
  }
  return salesDataList;
}

// 홈 화면에서 사용될 각각의 채널의 최신영상 데이터를 가져오는 함수
Future<void> getLatestYoutubeData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final url = Uri.parse('$httpURL/youtube/getLatestVideoInfo');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)['videos'];

      data.forEach((channelId, videoData) {
        youtubeDataController.latestYoutubeData[channelId] = HomeYoutubeDataClass(
          videoData['title'] ?? '',
          videoData['thumbnail'] ?? '',
          videoData['publishedAt'] ?? '',
          videoData['videoUrl'] ?? '',
          videoData['channelName'] ?? '',
        );
      });
      logger.i('getLatestYoutubeData log : Latest Videos stored successfully.');
    } else {
      logger.w(
          'getLatestYoutubeData log : Failed to fetch latest videos. Status code: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('getLatestYoutubeData error : $e');
  }
}

// 채널의 데이터들을 가져오는 함수
Future<void> getYoutubeChannelData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final url = Uri.parse('$httpURL/youtube/getchannelinfo');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)['channel'];

      data.forEach((channelId, videoData) {
        youtubeDataController.youtubeChannelData[channelId] = YoutubeChannelDataClass(
            videoData['title'] ?? '',
            videoData['thumbnails'] ?? '',
            videoData['birthday'] ?? '',
            videoData['description'] ?? '',
            videoData['subscribercount'] ?? '');
      });

      logger.i('getYoutubeChannelData log : Videos Channel Data stored successfully.');
    } else {
      logger.w(
          'getYoutubeChannelData log : Failed to fetch Videos Channel Data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('getYoutubeChannelData error : $e');
  }
}

// 각각의 아이템 가격 데이터를 가져오는 함수
Future<void> getYoutubeLiveData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final url = Uri.parse('$httpURL/youtube/getlivedata');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> countMapData =
          jsonDecode(response.body)['countMapData']; // 메인 채널 데이터
      final Map<String, dynamic> countSubMapData =
          jsonDecode(response.body)['countSubMapData']; // 서브 채널 데이터
      final Map<String, dynamic> chartDataList =
          jsonDecode(response.body)['chartDataList']; // 차트 데이터

      countMapData.forEach((channelId, videoData) {
        youtubeDataController.youtubeLiveData[channelId] = YoutubeLiveDataClass(
          videoData['differenceCommentCount'] ?? 0,
          videoData['differenceLikeCount'] ?? 0,
          videoData['differenceViewCount'] ?? 0,
          videoData['lastDifferenceCommentCount'] ?? 0,
          videoData['lastDifferenceLikeCount'] ?? 0,
          videoData['lastDifferenceViewCount'] ?? 0,
          videoData['lastTotalCommentCount'] ?? 0,
          videoData['lastTotalLikeCount'] ?? 0,
          videoData['lastTotalViewCount'] ?? 0,
          videoData['totalCommentCount'] ?? 0,
          videoData['totalLikeCount'] ?? 0,
          videoData['totalViewCount'] ?? 0,
          videoData['lastCommentCountPrice'] ?? 0,
          videoData['lastViewCountPrice'] ?? 0,
          videoData['lastLikeCountPrice'] ?? 0,
          videoData['commentCountPrice'] ?? 0,
          videoData['likeCountPrice'] ?? 0,
          videoData['viewCountPrice'] ?? 0,
          videoData['viewDelisting'] ?? 0,
          videoData['likeDelisting'] ?? 0,
          videoData['commentDelisting'] ?? 0,
          videoData['updateTime'] ?? '',
        );
      });

      countSubMapData.forEach((channelId, videoData) {
        youtubeDataController.youtubeLiveData[channelId] = YoutubeLiveDataClass(
          videoData['differenceCommentCount'] ?? 0,
          videoData['differenceLikeCount'] ?? 0,
          videoData['differenceViewCount'] ?? 0,
          videoData['lastDifferenceCommentCount'] ?? 0,
          videoData['lastDifferenceLikeCount'] ?? 0,
          videoData['lastDifferenceViewCount'] ?? 0,
          videoData['lastTotalCommentCount'] ?? 0,
          videoData['lastTotalLikeCount'] ?? 0,
          videoData['lastTotalViewCount'] ?? 0,
          videoData['totalCommentCount'] ?? 0,
          videoData['totalLikeCount'] ?? 0,
          videoData['totalViewCount'] ?? 0,
          videoData['lastCommentCountPrice'] ?? 0,
          videoData['lastViewCountPrice'] ?? 0,
          videoData['lastLikeCountPrice'] ?? 0,
          videoData['commentCountPrice'] ?? 0,
          videoData['likeCountPrice'] ?? 0,
          videoData['viewCountPrice'] ?? 0,
          videoData['viewDelisting'] ?? 0,
          videoData['likeDelisting'] ?? 0,
          videoData['commentDelisting'] ?? 0,
          videoData['updateTime'] ?? '',
        );
      });

      // 각각의 데이터들을 형식에 맞게 저장하기 위해 변환 후 저장
      chartDataList.forEach((channelId, videoData) {
        youtubeDataController.youtubeChartData[channelId] = YoutubeChartDataClass(
          convertViewCountToSalesData(
            (videoData['commentCount'] as List<dynamic>?)
                    ?.map((e) => int.tryParse(e.toString()) ?? 0)
                    .toList() ??
                [0],
          ),
          convertViewCountToSalesData(
            (videoData['likeCount'] as List<dynamic>?)
                    ?.map((e) => int.tryParse(e.toString()) ?? 0)
                    .toList() ??
                [0],
          ),
          convertViewCountToSalesData(
            (videoData['viewCount'] as List<dynamic>?)
                    ?.map((e) => int.tryParse(e.toString()) ?? 0)
                    .toList() ??
                [0],
          ),
        );
      });
      logger.i('getYoutubeLiveData log : YoutubeLiveData stored successfully.');
    } else {
      logger.w(
          'getYoutubeLiveData log : Failed to fetch YoutubeLiveData. Status code: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('getYoutubeLiveData error : $e');
  }
}

// 각각의 채널의 비디오 데이터를 가져오는 함수
Future<void> getYoutubeVideoData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final url = Uri.parse('$httpURL/youtube/getvideodata');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> countMapData = jsonDecode(response.body)['channel'];
      countMapData.forEach((channelId, videoListData) {
        List<YoutubeVideoDataClass> videoList = (videoListData as List<dynamic>).map((videoData) {
          return YoutubeVideoDataClass(
            videoData['videoid']?.toString() ?? '',
            videoData['title']?.toString() ?? '',
            videoData['description']?.toString() ?? '',
            videoData['thumbnailurl']?.toString() ?? '',
            videoData['publishedat']?.toString() ?? '',
          );
        }).toList();

        youtubeDataController.youtubeVideoData[channelId] = videoList;
      });
      logger.i('getYoutubeVideoData log : YoutubeVideoData stored successfully.');
    } else {
      logger.w(
          'getYoutubeVideoData log : Failed to fetch YoutubeVideoData. Status code: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('getYoutubeVideoData error : $e');
  }
}
