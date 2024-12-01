import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/trade_system.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/format.dart';
import '../../data/public_data.dart';
import '../../data/youtube_data.dart';
import '../../utils/screen_size.dart';

// 필터 버튼 위젯
class TradeSelectWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final TradeController _tradeController = Get.find<TradeController>();
  TradeSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: _screenController.screenSize.value.getWidthPerSize(2),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            Get.bottomSheet(
              Container(
                width: _screenController.screenSize.value.getWidthSize(),
                padding: EdgeInsets.all(
                  _screenController.screenSize.value.getHeightPerSize(2),
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BottomSheetWidget(
                      title: '전체',
                      onTap: () {
                        _tradeController.dropdownItem.value = '전체';
                        Get.back();
                      },
                    ),
                    BottomSheetWidget(
                      title: '조회수',
                      onTap: () {
                        _tradeController.dropdownItem.value = '조회수';
                        Get.back();
                      },
                    ),
                    BottomSheetWidget(
                      title: '좋아요수',
                      onTap: () {
                        _tradeController.dropdownItem.value = '좋아요수';
                        Get.back();
                      },
                    ),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    const Divider(color: Colors.grey, thickness: 1),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    BottomSheetWidget(
                      title: '취소',
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              isScrollControlled: true, // 필요시 전체 화면 BottomSheet 설정
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.tune,
                size: _screenController.screenSize.value.getHeightPerSize(2),
              ),
              Obx(
                () => Text(
                  _tradeController.dropdownItem.value,
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
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
                visible: _tradeController.dropdownItem.value == '전체' ||
                    _tradeController.dropdownItem.value == '조회수',
                child: TradeItemWidget(
                  channelUID: channelIdList[index],
                  index: index,
                  type: 'view',
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: _tradeController.dropdownItem.value == '전체',
                child: SizedBox(
                  height: _screenController.screenSize.value.getHeightPerSize(0.5),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: _tradeController.dropdownItem.value == '전체' ||
                    _tradeController.dropdownItem.value == '좋아요수',
                child: TradeItemWidget(
                  channelUID: channelIdList[index],
                  index: index,
                  type: 'like',
                ),
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(0.5),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.1,
            blurRadius: 0.1,
            offset: Offset(0, 0),
          ),
        ],
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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: _screenController.screenSize.value.getHeightPerSize(6),
                    height: _screenController.screenSize.value.getHeightPerSize(6),
                    child: Image.network(
                      type == 'view'
                          ? _youtubeDataController.youtubeChannelData[channelUID]!.thumbnail
                          : _youtubeDataController
                              .youtubeChannelData[channelAndSubChannelMapData[channelUID]]!
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
                          child: Image.asset('assets/image/image_error.png'), // 오류 시 표시할 텍스트
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: -10,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green)),
                      child: Icon(
                        type == 'view' ? Icons.visibility : Icons.thumb_up,
                        color: Colors.green,
                        size: _screenController.screenSize.value.getHeightPerSize(2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              Text(
                '${channelNameList[index]} ${type == 'view' ? '(조회수)' : '(좋아요수)'}',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                ),
              ),
              const Spacer(),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      type == 'view'
                          ? formatToCurrency(
                              _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice)
                          : formatToCurrency(
                              _youtubeDataController.youtubeLiveData[channelUID]!.likeCountPrice),
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                      ),
                    ),
                    differenceTextWidget(type == 'view'
                        ? _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice -
                            _youtubeDataController.youtubeLiveData[channelUID]!.lastViewCountPrice
                        : _youtubeDataController.youtubeLiveData[channelUID]!.likeCountPrice -
                            _youtubeDataController.youtubeLiveData[channelUID]!.lastLikeCountPrice),
                  ],
                ),
              ),
              SizedBox(
                width: _screenController.screenSize.value.getHeightPerSize(3),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 가격 변동값 설정
Widget differenceTextWidget(int differenceInt) {
  final ScreenController screenController = Get.find<ScreenController>();
  String pm = '';
  Color textColor;

  if (differenceInt > 0) {
    pm = '+';
    textColor = Colors.red;
  } else if (differenceInt < 0) {
    textColor = Colors.blue;
  } else {
    textColor = Colors.grey;
  }

  return Text(
    '$pm${differenceInt.toString()}',
    style: TextStyle(
        color: textColor, fontSize: screenController.screenSize.value.getHeightPerSize(1.8)),
  );
}

// 바텀 시트 커스텀 위젯
class BottomSheetWidget extends StatelessWidget {
  final TradeController _tradeController = Get.find<TradeController>();
  final ScreenController _screenController = Get.find<ScreenController>();
  final VoidCallback onTap;
  final String title;

  BottomSheetWidget({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _screenController.screenSize.value.getHeightPerSize(6),
        width: _screenController.screenSize.value.getWidthSize(),
        color: Colors.transparent,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                color:
                    _tradeController.dropdownItem.value == title ? colorISEGYEIDOL : Colors.black),
          ),
        ),
      ),
    );
  }
}
