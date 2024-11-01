import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:stockpj/data/public_data.dart';
import 'dart:convert';

import 'package:stockpj/utils/http_request.dart';

import '../main/trade/detail/trade_detail_system.dart';

Map<String, String> channelMapData = Map.fromIterables(channelIdList, channelNameList);

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

// class YoutubeChartDataClass {
//   List<int> commentCount;
//   List<int> likeCount;
//   List<int> viewCount;
//
//   YoutubeChartDataClass(this.commentCount, this.likeCount, this.viewCount);
// }

class YoutubeChartDataClass {
  List<SalesData> commentCount;
  List<SalesData> likeCount;
  List<SalesData> viewCount;

  YoutubeChartDataClass(this.commentCount, this.likeCount, this.viewCount);
}

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
    this.updateTime,
  );
}

class YoutubeDataController extends GetxController {
  RxMap<String, HomeYoutubeDataClass> latestYoutubeData = <String, HomeYoutubeDataClass>{}.obs;
  RxMap<String, YoutubeChannelDataClass> youtubeChannelData =
      <String, YoutubeChannelDataClass>{}.obs;
  RxMap<String, YoutubeLiveDataClass> youtubeLiveData = <String, YoutubeLiveDataClass>{}.obs;
  RxMap<String, YoutubeChartDataClass> youtubeChartData = <String, YoutubeChartDataClass>{}.obs;
  RxMap<String, List<YoutubeVideoDataClass>> youtubeVideoData =
      <String, List<YoutubeVideoDataClass>>{}.obs;
}

List<SalesData> convertViewCountToSalesData(List<int> viewCountList) {
  List<SalesData> salesDataList = [];

  // 현재 시간을 가져와 5분 단위로 내림 처리
  DateTime now = DateTime.now();
  DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, (now.minute ~/ 5) * 5);

  // viewCountList를 순회하며 SalesData로 변환
  for (int i = viewCountList.length - 1; i >= 0; i--) {
    // 현재 시간을 hh:mm 형식으로 변환
    String formattedTime = DateFormat('HH:mm').format(currentTime);

    // SalesData 객체에 현재 시간과 해당 viewCount 값을 추가
    salesDataList.add(SalesData(formattedTime, viewCountList[i].toDouble()));

    // 다음 시간은 현재 시간에서 5분 빼서 설정
    currentTime = currentTime.subtract(Duration(minutes: 5));
  }

  return salesDataList;
}

Future<void> getLatestYoutubeData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final url = Uri.parse('$httpURL/youtube/getLatestVideoInfo'); // 서버 주소와 엔드포인트

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // JSON 데이터 파싱
      final Map<String, dynamic> data = jsonDecode(response.body)['videos'];

      // 데이터를 HomeYoutubeDataClass 객체로 변환하여 LatestYoutubeData에 저장
      data.forEach((channelId, videoData) {
        youtubeDataController.latestYoutubeData[channelId] = HomeYoutubeDataClass(
          videoData['title'] ?? '',
          videoData['thumbnail'] ?? '',
          videoData['publishedAt'] ?? '',
          videoData['videoUrl'] ?? '',
          videoData['channelName'] ?? '',
        );
      });

      // 저장된 데이터를 확인
      print('Latest Videos stored successfully.');
    } else {
      print('Failed to fetch latest videos. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching latest videos: $error');
  }
}

Future<void> getYoutubeChannelData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final url = Uri.parse('$httpURL/youtube/getchannelinfo'); // 서버 주소와 엔드포인트

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

      // 저장된 데이터를 확인
      print('Videos Channel Data stored successfully.');
    } else {
      print('Failed to fetch Videos Channel Data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching Videos Channel Data: $error');
  }
}

Future<void> getYoutubeLiveData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final url = Uri.parse('$httpURL/youtube/getlivedata');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> countMapData = jsonDecode(response.body)['countMapData'];
      final Map<String, dynamic> chartDataList = jsonDecode(response.body)['chartDataList'];

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
          videoData['updateTime'] ?? '',
        );
      });

      // chartDataList.forEach((channelId, videoData) {
      //   youtubeDataController.youtubeChartData[channelId] = YoutubeChartDataClass(
      //     (videoData['commentCount'] as List<dynamic>?)
      //             ?.map((e) => int.tryParse(e.toString()) ?? 0)
      //             .toList() ??
      //         [0],
      //     (videoData['likeCount'] as List<dynamic>?)
      //             ?.map((e) => int.tryParse(e.toString()) ?? 0)
      //             .toList() ??
      //         [0],
      //     (videoData['viewCount'] as List<dynamic>?)
      //             ?.map((e) => int.tryParse(e.toString()) ?? 0)
      //             .toList() ??
      //         [0],
      //   );

      chartDataList.forEach((channelId, videoData) {
        youtubeDataController.youtubeChartData[channelId] = YoutubeChartDataClass(
          convertViewCountToSalesData(
            (videoData['commentCount'] as List<dynamic>?) // List<dynamic>을 받아서
                    ?.map((e) => int.tryParse(e.toString()) ?? 0) // 각 항목을 int로 변환
                    .toList() ??
                [0], // 변환한 값을 List<int>로 만들고, null일 경우 [0]을 기본값으로 설정
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
      //   List<SalesData> testList = convertViewCountToSalesData(
      //       youtubeDataController.youtubeChartData[channelId]!.viewCount);
      // });

      print('YoutubeLiveData stored successfully.');
    } else {
      print('Failed to fetch YoutubeLiveData. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching YoutubeLiveData: $error');
  }
}

Future<void> getYoutubeVideoData() async {
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final url = Uri.parse('$httpURL/youtube/getvideodata');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // 서버로부터 받아온 데이터를 JSON으로 디코딩
      final Map<String, dynamic> countMapData = jsonDecode(response.body)['channel'];

      // countMapData는 Map<String, dynamic>이며 각 key는 channelId를 의미
      countMapData.forEach((channelId, videoListData) {
        // videoListData는 List<dynamic>이므로 이를 List<YoutubeVideoDataClass>로 변환
        List<YoutubeVideoDataClass> videoList = (videoListData as List<dynamic>).map((videoData) {
          return YoutubeVideoDataClass(
            videoData['videoid']?.toString() ?? '',
            videoData['title']?.toString() ?? '',
            videoData['description']?.toString() ?? '',
            videoData['thumbnailurl']?.toString() ?? '',
            videoData['publishedat']?.toString() ?? '',
          );
        }).toList();

        // 해당 채널의 ID에 대해 비디오 리스트를 저장 (Map<String, List<YoutubeVideoDataClass>> 형태)
        youtubeDataController.youtubeVideoData[channelId] = videoList;
      });

      print('YoutubeVideoData stored successfully.');
    } else {
      print('Failed to fetch YoutubeVideoData. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching YoutubeVideoData: $error');
  }
}
