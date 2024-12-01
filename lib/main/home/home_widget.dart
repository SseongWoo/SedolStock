import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:stockpj/main/home/home_system.dart';
import 'package:stockpj/utils/simple_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/public_data.dart';
import '../../utils/custom_scroll.dart';
import '../../utils/format.dart';
import '../../utils/get_env.dart';
import '../../utils/screen_size.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// 사용자 정보 위젯
class HomeMyDataWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  HomeMyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(
          _screenController.screenSize.value.getHeightPerSize(1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(8),
              width: _screenController.screenSize.value.getHeightPerSize(8),
              decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              child: Obx(
                () => Center(
                  child: ClipOval(
                    child: Image.asset(
                        'assets/image/fan/${fanImageMap[_myDataController.myChoicechannel.value]}.png'),
                  ),
                ),
              ),
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

// 최신영상 리스트 위젯
class HomeLatestVideoListWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final HomeController _homeController = Get.find<HomeController>();
  HomeLatestVideoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_homeController.mainChannelVideoList.value ? '메인' : '서브'}채널 최신영상',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _homeController.mainChannelVideoList.value =
                          !_homeController.mainChannelVideoList.value;
                    },
                    child: Text(
                      _homeController.mainChannelVideoList.value ? '서브' : '메인',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1.2),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(40), // 높이 지정
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ListView.builder(
                    itemCount: _homeController.getVideoList().length, // 아이템 개수 설정
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: _screenController.screenSize.value.getHeightPerSize(12),
                        width: double.infinity,
                        child: Row(
                          children: [
                            SizedBox(
                              height: _screenController.screenSize.value.getHeightPerSize(10),
                              width: _screenController.screenSize.value.getHeightPerSize(16),
                              child: Image.network(
                                _youtubeDataController
                                    .latestYoutubeData[_homeController.getVideoList()[index]]!
                                    .thumbnail,
                                fit: BoxFit.cover, // 이미지가 부모 컨테이너에 맞도록
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child; // 로딩이 완료되면 이미지 표시
                                  return const Center(
                                    child: CircularProgressIndicator(), // 로딩 중인 동안 표시
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child:
                                        Image.asset('assets/image/image_error.png'), // 오류 시 표시할 텍스트
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: _screenController.screenSize.value.getWidthPerSize(2),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    _youtubeDataController
                                        .latestYoutubeData[_homeController.getVideoList()[index]]!
                                        .title,
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
                                        .latestYoutubeData[_homeController.getVideoList()[index]]!
                                        .channelName,
                                    style: TextStyle(
                                      fontSize:
                                          _screenController.screenSize.value.getHeightPerSize(1.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: _screenController.screenSize.value.getWidthPerSize(10),
                              child: IconButton(
                                onPressed: () async {
                                  final Uri url = Uri.parse(
                                    _youtubeDataController
                                        .latestYoutubeData[_homeController.getVideoList()[index]]!
                                        .videoUrl,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 채널 리스트 위젯
class HomeChannelDataWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final HomeController _homeController = Get.find<HomeController>();
  HomeChannelDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_homeController.mainChannelList.value ? '메인' : '서브'}채널 바로가기',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _homeController.mainChannelList.value =
                          !_homeController.mainChannelList.value;
                    },
                    child: Text(
                      _homeController.mainChannelList.value ? '서브' : '메인',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1.2),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1),
              ), // 높이 지정
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(18),
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _homeController.getChannelList().length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        //height: _screenController.screenSize.value.getHeightPerSize(20),
                        width: _screenController.screenSize.value.getWidthPerSize(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: _screenController.screenSize.value.getHeightPerSize(8),
                              width: _screenController.screenSize.value.getHeightPerSize(8),
                              child: ClipOval(
                                child: Image.network(
                                  _youtubeDataController
                                      .youtubeChannelData[_homeController.getChannelList()[index]]!
                                      .thumbnail,
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
                                    return Center(
                                      child: Image.asset(
                                          'assets/image/image_error.png'), // 오류 시 표시할 텍스트
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _screenController.screenSize.value.getHeightPerSize(1),
                            ),
                            SizedBox(
                              height: _screenController.screenSize.value.getHeightPerSize(2),
                              child: AutoSizeText(
                                _youtubeDataController
                                    .youtubeChannelData[_homeController.getChannelList()[index]]!
                                    .title,
                                minFontSize: 10,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize:
                                      _screenController.screenSize.value.getHeightPerSize(1.8),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final Uri url = Uri.parse(
                                    'https://www.youtube.com/channel/${_homeController.getChannelList()[index]}');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  showSimpleDialog(Get.back, '이동 실패', '이동에 실패했습니다.\n다시 시도해 주세요');
                                }
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.youtube,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 카페 이동 위젯
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
                  return Center(
                    child: Image.asset('assets/image/image_error.png'), // 오류 시 표시할 텍스트
                  );
                },
              ),
            ),
            SizedBox(
              width: _screenController.screenSize.value.getWidthPerSize(3),
            ),
            Expanded(
              child: Text(
                '왁물원',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                final Uri url = Uri.parse(cafeURL);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  showSimpleDialog(Get.back, '이동 실패', '이동에 실패했습니다.\n다시 시도해 주세요');
                }
              },
              icon: const FaIcon(
                FontAwesomeIcons.mugSaucer,
                color: Color(0xff06CC80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
