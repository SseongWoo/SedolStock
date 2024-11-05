import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/trade_system.dart';
import 'package:stockpj/utils/format.dart';
import '../../data/public_data.dart';
import '../../data/youtube_data.dart';
import '../../utils/screen_size.dart';

class TradeItemListWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  TradeItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: channelIdList.length, // 아이템 개수 설정
      itemBuilder: (context, index) {
        return TradeItemWidget(
          channelUID: channelIdList[index],
          index: index,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: _screenController.screenSize.value.getHeightPerSize(0.5),
      ),
    );
  }
}

class TradeItemWidget extends StatelessWidget {
  final String channelUID;
  final int index;
  final TradeController _tradeController = Get.find<TradeController>();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final ScreenController _screenController = Get.find<ScreenController>();

  TradeItemWidget({super.key, required this.channelUID, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenController.screenSize.value.getHeightPerSize(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _tradeController.goTradeItem(channelUID);
          },
          child: Row(
            children: [
              SizedBox(
                width: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              SizedBox(
                width: _screenController.screenSize.value.getHeightPerSize(6),
                height: _screenController.screenSize.value.getHeightPerSize(6),
                child: Image.network(
                  _youtubeDataController.youtubeChannelData[channelUID]!.thumbnail,
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
                width: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              Text(
                channelNameList[index],
                style:
                    TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.6)),
              ),
              const Spacer(),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatToCurrency(
                          _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice),
                      style: TextStyle(
                          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8)),
                    ),
                    differenceTextWidget(
                        _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice -
                            _youtubeDataController.youtubeLiveData[channelUID]!.lastViewCountPrice),
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
