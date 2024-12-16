import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/main/trade/trade_system.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/format.dart';
import 'package:stockpj/utils/timer.dart';
import '../../data/public_data.dart';
import '../../data/youtube_data.dart';
import '../../utils/screen_size.dart';

// 상단 로딩 바 위젯
class TradeProgressBarWidget extends StatefulWidget {
  const TradeProgressBarWidget({super.key});

  @override
  State<TradeProgressBarWidget> createState() => _TradeProgressBarWidgetState();
}

class _TradeProgressBarWidgetState extends State<TradeProgressBarWidget> {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final TimerController _timerController = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _screenController.screenSize.value.getWidthSize(),
      height: _screenController.screenSize.value.getHeightPerSize(2),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Obx(
            () => AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: !_timerController.checkDataTime.value
                  ? _screenController.screenSize.value.getWidthSize() *
                      (_timerController.secondsRemaining.value / 180)
                  : 0, // 진행률 계산
              height: _screenController.screenSize.value.getHeightPerSize(2),
              decoration: BoxDecoration(
                color: fanColorMap[_myDataController.myChoicechannel.value],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TradeListTitleWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  TradeListTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenController.screenSize.value.getHeightPerSize(5),
      width: _screenController.screenSize.value.getWidthSize(),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorSUB,
            width: 1.5,
          ),
          bottom: BorderSide(
            color: colorSUB,
            width: 1.5,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: _screenController.screenSize.value.getWidthPerSize(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '채널',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: _screenController.screenSize.value.getWidthPerSize(1),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '가격',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: _screenController.screenSize.value.getWidthPerSize(25),
              child: Text(
                '등락폭',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 주식 아이템 리스트뷰 위젯
class TradeItemListWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final TradeController _tradeController = Get.find<TradeController>();
  TradeItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: channelIdList.length, // 아이템 개수 설정
      itemBuilder: (context, index) {
        return Column(
          children: [
            Obx(
              () => Visibility(
                visible: _tradeController.selectItemType.value == '전체' ||
                    _tradeController.selectItemType.value == '조회수',
                child: TradeItemWidget(
                  channelUID: channelIdList[index],
                  index: index,
                  type: 'view',
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: _tradeController.selectItemType.value == '전체' ||
                    _tradeController.selectItemType.value == '좋아요수',
                child: TradeItemWidget(
                  channelUID: channelIdList[index],
                  index: index,
                  type: 'like',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// 리스트뷰 아이템 위젯
class TradeItemWidget extends StatelessWidget {
  final String channelUID;
  final int index;
  final String type;
  final TradeController _tradeController = Get.find<TradeController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final ScreenController _screenController = Get.find<ScreenController>();

  TradeItemWidget({super.key, required this.channelUID, required this.index, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenController.screenSize.value.getHeightPerSize(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xffA6A6A6),
            width: 0.25,
          ),
          bottom: BorderSide(
            color: Color(0xffA6A6A6),
            width: 0.25,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _tradeController.goTradeItem(channelUID, type);
          },
          child: Row(
            children: [
              SizedBox(
                width: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              SizedBox(
                width: _screenController.screenSize.value.getHeightPerSize(6),
                height: _screenController.screenSize.value.getHeightPerSize(6),
                child: ClipOval(
                  child: Image.network(
                    type == 'view'
                        ? _youtubeDataController.youtubeChannelData[channelUID]!.thumbnail
                        : _youtubeDataController
                            .youtubeChannelData[channelAndSubChannelMapData[channelUID]]!.thumbnail,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
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
                width: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              SizedBox(
                width: _screenController.screenSize.value.getWidthPerSize(30),
                child: Text(
                  type == 'view'
                      ? _youtubeDataController.youtubeChannelData[channelUID]!.title
                      : _youtubeDataController
                          .youtubeChannelData[channelAndSubChannelMapData[channelUID]]!.title,
                  //'${channelNameList[index]} ${type == 'view' ? '(조회수)' : '(좋아요수)'}',
                  softWrap: true,

                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                  ),
                ),
              ),
              const Spacer(),
              Obx(
                () => Text(
                  type == 'view'
                      ? _youtubeDataController.youtubeLiveData[channelUID]!.viewDelisting > 0
                          ? '상장 폐지 중...'
                          : formatToCurrency(
                              _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice)
                      : _youtubeDataController.youtubeLiveData[channelUID]!.likeDelisting > 0
                          ? '상장 폐지 중...'
                          : formatToCurrency(
                              _youtubeDataController.youtubeLiveData[channelUID]!.likeCountPrice),
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                  ),
                ),
              ),
              SizedBox(
                width: _screenController.screenSize.value.getHeightPerSize(3),
              ),
              SizedBox(
                width: _screenController.screenSize.value.getWidthPerSize(24),
                child: Obx(
                  () => differenceTextWidget(
                      type == 'view'
                          ? _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice -
                              _youtubeDataController.youtubeLiveData[channelUID]!.lastViewCountPrice
                          : _youtubeDataController.youtubeLiveData[channelUID]!.likeCountPrice -
                              _youtubeDataController
                                  .youtubeLiveData[channelUID]!.lastLikeCountPrice,
                      type == 'view'
                          ? _youtubeDataController.youtubeLiveData[channelUID]!.viewDelisting
                          : _youtubeDataController.youtubeLiveData[channelUID]!.likeDelisting,
                      type == 'view'
                          ? _youtubeDataController.youtubeLiveData[channelUID]!.lastViewCountPrice
                          : _youtubeDataController.youtubeLiveData[channelUID]!.lastLikeCountPrice),
                ),
              ),
              // SizedBox(
              //   width: _screenController.screenSize.value.getHeightPerSize(1),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// 가격 변동값 설정
Widget differenceTextWidget(int differenceInt, int delisting, int lastPrice) {
  final ScreenController screenController = Get.find<ScreenController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  String pm = '';
  Color textColor;
  double ratio = (differenceInt / lastPrice) * 100;

  if (delisting > 0) {
    textColor = Colors.grey;
    return Text(
      delisting.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: screenController.screenSize.value.getHeightPerSize(1.8),
      ),
    );
  } else {
    if (differenceInt > 0) {
      pm = '+';
      textColor = Colors.red;
    } else if (differenceInt < 0) {
      textColor = Colors.blue;
    } else {
      textColor = Colors.grey;
    }

    return Text(
      '$pm${differenceInt.toString()}\n($pm${ratio.toStringAsFixed(2)}%)',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: screenController.screenSize.value.getHeightPerSize(1.6),
      ),
    );
  }
}

// 필터 버튼 위젯
class TradeFilterWidget extends StatelessWidget {
  final TradeController _tradeController = Get.find<TradeController>();
  final ScreenController _screenController = Get.find<ScreenController>();
  TradeFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: _screenController.screenSize.value.getWidthPerSize(1),
            top: _screenController.screenSize.value.getHeightPerSize(0.1),
            bottom: _screenController.screenSize.value.getHeightPerSize(0.1),
          ),
          child: Obx(
            () => Wrap(
              spacing: _screenController.screenSize.value.getWidthPerSize(1),
              runSpacing: 4.0,
              children: _tradeController.dropdownItemList.map((filter) {
                return ChoiceChip(
                  label: Text(filter),
                  selected: _tradeController.selectItemType.value == filter,
                  showCheckmark: false,
                  onSelected: (bool selected) {
                    _tradeController.selectItemTypeFilter(filter);
                  },
                  selectedColor: colorSUB,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: _tradeController.selectItemType.value == filter
                        ? Colors.white
                        : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // 모서리를 각지게 설정
                    side: BorderSide(
                      color: colorSUB,
                      width: 1.5,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: _screenController.screenSize.value.getWidthPerSize(2),
          ),
          child: Tooltip(
            message: '툴팁 메세지',
            triggerMode: TooltipTriggerMode.tap,
            child: Icon(
              Icons.info_outline,
              size: _screenController.screenSize.value.getHeightPerSize(3),
            ),
          ),
        ),
      ],
    );
  }
}
