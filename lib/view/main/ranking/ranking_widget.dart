import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/constants/color_constants.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../data/public_data.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/format.dart';
import '../../../utils/level.dart';

// 랭킹 탭 화면
class RankingTapScreen extends StatelessWidget {
  final ScreenSize screenSize;
  final List<RankingDataClass> rankingList;
  final Color Function(int rank) rankingColor;
  final Color backgroundColor;
  final Color textColor;
  const RankingTapScreen({
    super.key,
    required this.screenSize,
    required this.rankingList,
    required this.rankingColor,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.only(
          left: screenSize.getWidthPerSize(2),
          right: screenSize.getWidthPerSize(2),
        ),
        child: rankingList.isNotEmpty
            ? ListView.builder(
                itemCount: rankingList.length,
                itemBuilder: (context, index) {
                  final rankingData = rankingList[index];
                  final rankingColor = this.rankingColor(rankingData.rank);

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenSize.getHeightPerSize(1),
                      horizontal: screenSize.getHeightPerSize(0.2),
                    ),
                    child: GestureDetector(
                      child: RankingWidget(
                        rankingData: rankingData,
                        screenSize: screenSize,
                        rankColor: rankingColor,
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  '랭킹 데이터를 불러오지 못했습니다.',
                  style: TextStyle(fontSize: screenSize.getHeightPerSize(2), color: textColor),
                ),
              ),
      ),
    );
  }
}

// 랭킹 리스트에 사용되는 랭킹 데이터 위젯
class RankingWidget extends StatelessWidget {
  final ScreenSize screenSize;
  final RankingDataClass rankingData;
  final Color rankColor;
  const RankingWidget(
      {super.key, required this.rankingData, required this.screenSize, required this.rankColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.getHeightPerSize(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.1,
            blurRadius: 0.1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: screenSize.getWidthPerSize(2),
          right: screenSize.getWidthPerSize(2),
        ),
        child: Row(
          children: [
            SizedBox(
              height: screenSize.getHeightPerSize(8),
              width: screenSize.getHeightPerSize(4),
              child: Center(
                child: AutoSizeText(
                  rankingData.rank.toString(),
                  style: TextStyle(
                    fontSize: screenSize.getHeightPerSize(3),
                    fontWeight: rankingData.rank < 4 ? FontWeight.bold : null,
                    color: rankColor,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(
              width: screenSize.getWidthPerSize(2),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                rankingData.rank == 1
                    ? Positioned(
                        top: -screenSize.getHeightPerSize(2),
                        left: -screenSize.getHeightPerSize(2),
                        child: Transform.rotate(
                          angle: -8 * (3.14159265359 / 180),
                          child: Image.asset(
                            'assets/image/ui/crown.png',
                            width: screenSize.getWidthPerSize(8),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Container(
                  height: screenSize.getHeightPerSize(6),
                  width: screenSize.getHeightPerSize(6),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.asset('assets/image/fan/${fanImageMap[rankingData.fandom]}.png',
                        errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/image/image_error.png');
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenSize.getWidthPerSize(2),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        rankingData.name,
                        style: TextStyle(
                          fontSize: screenSize.getHeightPerSize(2),
                          fontWeight: FontWeight.bold,
                          color: rankingData.level > 0 ? colorMAIN : Colors.black,
                          shadows: rankingData.level > 0
                              ? [
                                  const Shadow(color: Colors.black, offset: Offset(-1, -1)),
                                  const Shadow(color: Colors.black, offset: Offset(1, -1)),
                                  const Shadow(color: Colors.black, offset: Offset(-1, 1)),
                                  const Shadow(color: Colors.black, offset: Offset(1, 1)),
                                ]
                              : rankingData.totalMoney >= 100000000
                                  ? [
                                      const Shadow(color: colorMAIN, offset: Offset(-0.5, -0.5)),
                                      const Shadow(color: colorMAIN, offset: Offset(0.5, -0.5)),
                                      const Shadow(color: colorMAIN, offset: Offset(-0.5, 0.5)),
                                      const Shadow(color: colorMAIN, offset: Offset(0.5, 0.5)),
                                    ]
                                  : null,
                        ),
                        maxLines: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: SizedBox(
                          width: screenSize.getWidthPerSize(12),
                          child: getLevelImage(rankingData.level) != 0
                              ? Image.asset(
                                  'assets/image/level/star${getLevelImage(rankingData.level)}.png')
                              : null,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: screenSize.getWidthPerSize(2),
                      ),
                      child: AutoSizeText(
                        '${formatToCurrency(rankingData.totalMoney)} P',
                        style: TextStyle(
                          fontSize: screenSize.getHeightPerSize(1.8),
                        ),
                        maxLines: 1,
                      ),
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

class CategoryDialog extends StatelessWidget {
  final ScreenSize screenSize;
  final List<String> categoryList;
  final RxString selectCategoryItem;
  final ValueChanged<String> selectCategory;
  const CategoryDialog(
      {super.key,
      required this.screenSize,
      required this.categoryList,
      required this.selectCategoryItem,
      required this.selectCategory});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: screenSize.getWidthPerSize(80),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: categoryList.map((filter) {
              return RadioListTile(
                value: filter,
                groupValue: selectCategoryItem.value,
                title: Text(
                  filter,
                  style: TextStyle(
                    fontSize: screenSize.getHeightPerSize(2),
                  ),
                ),
                onChanged: (String? newValue) {
                  selectCategory(newValue!);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
