import 'package:flutter/material.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:stockpj/utils/simple_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/public_data.dart';
import '../../utils/format.dart';
import '../../utils/http_request.dart';
import '../../utils/screen_size.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeMyDataWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  HomeMyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      // height: _screenController.screenSize.value.getHeightPerSize(12),
      // width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(8),
              width: _screenController.screenSize.value.getHeightPerSize(8),
              decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              child: Center(child: const Text('프사')),
            ),
            SizedBox(
              width: _screenController.screenSize.value.getWidthPerSize(4),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    _myDataController.myName.value,
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    '총 자산 : ${formatToCurrency(_myDataController.myTotalMoney.value)}',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    '가용 자산 : ${formatToCurrency(_myDataController.myMoney.value)}',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    '보유 주식 자산 : ${formatToCurrency(_myDataController.myStockMoney.value)}',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeLatestVideoListWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  HomeLatestVideoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '최신 영상',
              style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.8)),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(40), // 높이 지정
              child: ListView.builder(
                itemCount: channelIdList.length, // 아이템 개수 설정
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: _screenController.screenSize.value.getHeightPerSize(10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        SizedBox(
                          height: _screenController.screenSize.value.getHeightPerSize(8),
                          width: _screenController.screenSize.value.getWidthPerSize(30),
                          child: Image.network(
                            _youtubeDataController
                                .latestYoutubeData[channelIdList[index]]!.thumbnail,
                            fit: BoxFit.cover, // 이미지가 부모 컨테이너에 맞도록
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child; // 로딩이 완료되면 이미지 표시
                              return const Center(
                                child: CircularProgressIndicator(), // 로딩 중인 동안 표시
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Text('이미지를 불러올 수 없습니다.'), // 오류 시 표시할 텍스트
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: _screenController.screenSize.value.getWidthPerSize(2),
                        ),
                        SizedBox(
                          width: _screenController.screenSize.value.getWidthPerSize(48),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                _youtubeDataController
                                    .latestYoutubeData[channelIdList[index]]!.title,
                                minFontSize: 10,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize:
                                      _screenController.screenSize.value.getHeightPerSize(1.8),
                                ),
                              ),
                              Text(
                                _youtubeDataController
                                    .latestYoutubeData[channelIdList[index]]!.channelName,
                                style: TextStyle(
                                  fontSize:
                                      _screenController.screenSize.value.getHeightPerSize(1.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                _youtubeDataController
                                    .latestYoutubeData[channelIdList[index]]!.videoUrl,
                              );
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                showSimpleDialog(Get.back, '이동 실패', '이동에 실패했습니다.\n다시 시도해 주세요');
                              }
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeChannelDataWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  HomeChannelDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '채널 바로가기',
              style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.8)),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(40), // 높이 지정
              child: ListView.builder(
                itemCount: channelIdList.length, // 아이템 개수 설정
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: _screenController.screenSize.value.getHeightPerSize(10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        SizedBox(
                          height: _screenController.screenSize.value.getHeightPerSize(8),
                          width: _screenController.screenSize.value.getHeightPerSize(8),
                          child: ClipOval(
                            child: Image.network(
                              _youtubeDataController
                                  .youtubeChannelData[channelIdList[index]]!.thumbnail,

                              fit: BoxFit.cover, // 이미지가 원형에 맞도록 조정
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // 로딩이 완료되면 이미지 표시
                                }
                                return const Center(
                                  child: CircularProgressIndicator(), // 로딩 중인 동안 표시할 위젯
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text('이미지를 불러올 수 없습니다.'), // 오류 시 표시할 텍스트
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: _screenController.screenSize.value.getWidthPerSize(2),
                        ),
                        SizedBox(
                          width: _screenController.screenSize.value.getWidthPerSize(48),
                          child: AutoSizeText(
                            _youtubeDataController.youtubeChannelData[channelIdList[index]]!.title,
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                  'https://www.youtube.com/channel/${channelIdList[index]}');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                showSimpleDialog(Get.back, '이동 실패', '이동에 실패했습니다.\n다시 시도해 주세요');
                              }
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCafeDataWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  HomeCafeDataWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Row(
          children: [
            // 썸네일 이미지 부분
            ClipOval(
              child: Image.network(
                height: _screenController.screenSize.value.getHeightPerSize(8),
                width: _screenController.screenSize.value.getHeightPerSize(8),
                _youtubeDataController.youtubeChannelData[channelIdList[0]]!.thumbnail,
                fit: BoxFit.cover, // 이미지가 원형에 맞도록 조정
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // 로딩이 완료되면 이미지 표시
                  }
                  return const Center(
                    child: CircularProgressIndicator(), // 로딩 중인 동안 표시할 위젯
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text('이미지를 불러올 수 없습니다.'), // 오류 시 표시할 텍스트
                  );
                },
              ),
            ),
            SizedBox(
              width: _screenController.screenSize.value.getWidthPerSize(3),
            ),
            Expanded(
              child: Text(
                '스텔라이브 팬카페',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
            ),

            // 바로가기 버튼
            ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse(cafeURL);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  showSimpleDialog(Get.back, '이동 실패', '이동에 실패했습니다.\n다시 시도해 주세요');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF03C75A), // 네이버 그린 색상
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                '바로가기',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
