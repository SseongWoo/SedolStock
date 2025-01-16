import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:stockpj/constants/color_constants.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../data/public_data.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/custom_scroll.dart';
import '../../../utils/format.dart';
import '../../../viewmodel/main/home_view_model.dart';
import '../../../widget/listview_item.dart';

// 사용자 정보 위젯
class UserInformationWidget extends StatelessWidget {
  final HomeViewModel viewModel;
  const UserInformationWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(
          screenSize.getHeightPerSize(1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => Container(
                height: screenSize.getHeightPerSize(8),
                width: screenSize.getHeightPerSize(8),
                decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                        'assets/image/fan/${fanImageMap[viewModel.myDataController.myChoicechannel.value]!}.png',
                        errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/image/image_error.png');
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenSize.getWidthPerSize(4),
            ),
            Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.myDataController.myName.value,
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(2),
                    ),
                  ),
                  _textWidget(
                      '총 자산', formatToCurrency(viewModel.myDataController.myTotalMoney.value)),
                  _textWidget('가용 자산', formatToCurrency(viewModel.myDataController.myMoney.value)),
                  _textWidget(
                      '보유 주식 자산', formatToCurrency(viewModel.myDataController.myStockMoney.value)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textWidget(String title, String value) {
    return Text(
      '$title : $value',
      style: TextStyle(
        fontSize: viewModel.screenController.screenSize.value.getHeightPerSize(1.4),
      ),
    );
  }
}

// 최신영상 리스트 위젯
class EventWidget extends StatelessWidget {
  final HomeViewModel viewModel;
  const EventWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '이벤트',
                  style: TextStyle(fontSize: screenSize.getHeightPerSize(1.8)),
                ),
                InkWell(
                  onTap: () => viewModel.goEvent(),
                  child: Text(
                    '더보기',
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(1.2)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(1),
            ),
            Obx(
              () {
                final List<EventClass> eventList =
                    viewModel.publicDataController.eventMap['ongoing'] ?? [];
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: colorMAIN),
                      borderRadius: BorderRadius.circular(15)),
                  child: eventList.isNotEmpty
                      ? Column(
                          children: eventList.take(3).map((event) {
                            return ListTile(
                              title: Text(event.title),
                              subtitle: Text('${event.eventStart} ~ ${event.eventEnd}'),
                            );
                          }).toList(),
                        )
                      : SizedBox(
                          height: screenSize.getHeightPerSize(10),
                          child: const Center(
                            child: Text('진행중인 이벤트가 없습니다.'),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 최신영상 리스트 위젯
class NewVideoListWidget extends StatelessWidget {
  final HomeViewModel viewModel;
  const NewVideoListWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${viewModel.currentVideoTitle.value}채널 최신영상',
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(1.8)),
                  ),
                  InkWell(
                    onTap: () => viewModel.toggleVideoList(),
                    child: Text(
                      viewModel.currentVideoTitle.value,
                      style: TextStyle(fontSize: screenSize.getHeightPerSize(1.2)),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                List<String> videoList = viewModel.getVideoList();
                return SizedBox(
                  height: screenSize.getHeightPerSize(40),
                  child: videoList.isEmpty
                      ? Center(
                          child: Text(
                            '표시할 영상이 없습니다.',
                            style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
                          ),
                        )
                      : ScrollConfiguration(
                          behavior: CustomScrollBehavior(),
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: videoList.length,
                            itemBuilder: (context, index) {
                              final videoData = viewModel
                                  .youtubeDataController.latestYoutubeData[videoList[index]];
                              if (videoData == null) {
                                return const Center(child: Text('데이터를 불러오지 못했습니다.'));
                              }
                              return buildVideoItem(
                                  screenSize, videoData, index, viewModel.goVideo);
                            },
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 채널 리스트 위젯
class ChannelListWidget extends StatelessWidget {
  final HomeViewModel viewModel;
  const ChannelListWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${viewModel.currentChannelTitle.value}채널 바로가기',
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(1.8),
                    ),
                  ),
                  InkWell(
                    onTap: () => viewModel.toggleChannelList(),
                    child: Text(
                      viewModel.currentChannelTitle.value,
                      style: TextStyle(
                        fontSize: screenSize.getHeightPerSize(1.2),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(1),
            ), // 높이 지정
            Obx(
              () {
                List<String> channelList = viewModel.getChannelList();
                return SizedBox(
                  height: screenSize.getHeightPerSize(18),
                  child: channelList.isEmpty
                      ? Center(
                          child: Text(
                            '표시할 영상이 없습니다.',
                            style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
                          ),
                        )
                      : ScrollConfiguration(
                          behavior: CustomScrollBehavior(),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: channelList.length,
                            itemBuilder: (context, index) {
                              final channelData = viewModel
                                  .youtubeDataController.youtubeChannelData[channelList[index]];

                              if (channelData == null) {
                                return const Center(child: Text('데이터를 불러오지 못했습니다.'));
                              }
                              return _buildChannelItem(screenSize, channelData, index);
                            },
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 리스트뷰 아이템 위젯
  Widget _buildChannelItem(ScreenSize screenSize, YoutubeChannelDataClass channelData, int index) {
    return SizedBox(
      width: screenSize.getWidthPerSize(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: screenSize.getHeightPerSize(8),
            width: screenSize.getHeightPerSize(8),
            child: ClipOval(
              child: Image.network(
                channelData.thumbnail,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Image.asset('assets/image/image_error.png'),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(1),
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(2),
            child: AutoSizeText(
              channelData.title,
              minFontSize: 10,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: screenSize.getHeightPerSize(1.8),
              ),
            ),
          ),
          IconButton(
            onPressed: () => viewModel.goChannel(index),
            icon: const FaIcon(
              FontAwesomeIcons.youtube,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

// 카페 이동 위젯
class CafeWidget extends StatelessWidget {
  final HomeViewModel viewModel;
  const CafeWidget({super.key, required this.viewModel});
  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
        child: Row(
          children: [
            // 썸네일 이미지 부분
            ClipOval(
              child: Image.network(
                height: screenSize.getHeightPerSize(8),
                width: screenSize.getHeightPerSize(8),
                viewModel.youtubeDataController.youtubeChannelData['UCzh4yY8rl38knH33XpNqXbQ']!
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
                        height: screenSize.getHeightPerSize(8),
                        width: screenSize.getHeightPerSize(8),
                        'assets/image/image_error.png'), // 오류 시 표시할 텍스트
                  );
                },
              ),
            ),
            SizedBox(
              width: screenSize.getWidthPerSize(3),
            ),
            Expanded(
              child: Text(
                '왁물원 바로가기',
                style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(1.8),
                ),
              ),
            ),
            IconButton(
              onPressed: () => viewModel.goCafe(),
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
