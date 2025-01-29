import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/format.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../constants/color_constants.dart';
import '../../../model/data/data_class.dart';
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
      height: screenSize.getHeightPerSize(GetPlatform.isDesktop ? 6 : 5),
      width: screenSize.getWidthSize(),
      decoration: const BoxDecoration(
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
      child: Row(
        children: [
          SizedBox(
            width: screenSize.getWidthPerSize(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            width: screenSize.getWidthPerSize(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}

// 가격 변동값 설정
Widget differenceTextWidget(ScreenSize screenSize, ItemPriceDataClass itemPriceData) {
  String pm = '';
  Color textColor;

  if (itemPriceData.delisting > 0) {
    textColor = Colors.grey;
    return Text(
      itemPriceData.delisting.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: screenSize.getHeightPerSize(1.8),
      ),
    );
  } else {
    if (itemPriceData.differencePrice > 0) {
      pm = '+';
    }
    textColor = profitAndLossColor(itemPriceData.differencePrice);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          '$pm${formatToCurrency(itemPriceData.differencePrice)}',
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            color: textColor,
            fontSize: screenSize.getHeightPerSize(1.6),
          ),
        ),
        AutoSizeText(
          '($pm${(itemPriceData.ratio.isFinite) ? itemPriceData.ratio.toStringAsFixed(2) : '0.00'}%)',
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            color: textColor,
            fontSize: screenSize.getHeightPerSize(1.6),
          ),
        ),
      ],
    );
  }
}
