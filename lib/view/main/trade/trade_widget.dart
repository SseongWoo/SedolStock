import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../data/youtube_data.dart';
import '../../../utils/color.dart';

// 리스트뷰 상단바 위젯
class TradeItemTitleWidget extends StatelessWidget {
  final ScreenSize screenSize;
  final Function(String type) icon;
  final Function(String type) onPressed;
  const TradeItemTitleWidget(
      {super.key, required this.screenSize, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.getHeightPerSize(5),
      width: screenSize.getWidthSize(),
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
          left: screenSize.getWidthPerSize(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text(
                    '채널',
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(2),
                      color: Colors.black,
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: () => onPressed('age'),
                      icon: icon('age'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenSize.getWidthPerSize(1),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text(
                    '가격',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(2),
                      color: Colors.black,
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: () => onPressed('price'),
                      icon: icon('price'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenSize.getWidthPerSize(25),
              child: Row(
                children: [
                  Text(
                    '등락폭',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(2),
                      color: Colors.black,
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: () => onPressed('diffPrice'),
                      icon: icon('diffPrice'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 가격 변동값 설정
Widget differenceTextWidget(ScreenSize screenSize, ItemPriceDataClass itemPriceDate) {
  String pm = '';
  Color textColor;

  if (itemPriceDate.delisting > 0) {
    textColor = Colors.grey;
    return Text(
      itemPriceDate.delisting.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: screenSize.getHeightPerSize(1.8),
      ),
    );
  } else {
    if (itemPriceDate.differencePrice > 0) {
      pm = '+';
    }
    textColor = profitAndLossColor(itemPriceDate.differencePrice);

    return Text(
      '$pm${itemPriceDate.differencePrice.toString()}\n($pm${itemPriceDate.ratio.toStringAsFixed(2)}%)',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: screenSize.getHeightPerSize(1.6),
      ),
    );
  }
}
