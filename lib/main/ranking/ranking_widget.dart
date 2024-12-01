import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/utils/format.dart';
import '../../utils/color.dart';
import '../../utils/date_time.dart';
import '../../utils/screen_size.dart';

// 랭킹 타이틀과 보조 타이틀 위젯
class RankingSubTitleWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  RankingSubTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '랭킹',
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
          ),
        ),
        Text(
          '${formatDateString4(_publicDataController.updateDate.value)} 01시 00분 기준',
          style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(1.2),
              color: Colors.grey[700]),
        ),
      ],
    );
  }
}

// 랭킹 리스트 뷰 위젯
class RankingListViewWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  RankingListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: _publicDataController.rankingList.length,
        itemBuilder: (context, index) {
          final rankingData = _publicDataController.rankingList[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: _screenController.screenSize.value.getHeightPerSize(1),
            ),
            child: GestureDetector(child: RankingWidget(rankingData: rankingData)),
          );
        },
      ),
    );
  }
}

// 사용자 랭킹 정보 위젯
class RankingMyWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  RankingMyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenController.screenSize.value.getHeightPerSize(10),
      decoration: BoxDecoration(
        color: fanColorMap[_myDataController.myChoicechannel.value],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: _screenController.screenSize.value.getWidthPerSize(2),
          right: _screenController.screenSize.value.getWidthPerSize(2),
        ),
        child: Row(
          children: [
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(8),
              width: _screenController.screenSize.value.getHeightPerSize(4),
              child: Center(
                child: Text(
                  _myDataController.myRank.value == 0 ? '-' : _myDataController.myRank.string,
                  style: GoogleFonts.barlowCondensed(
                    fontWeight: FontWeight.w800,
                    fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                  ),
                ),
              ),
            ),
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(6),
              width: _screenController.screenSize.value.getHeightPerSize(6),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                    'assets/image/fan/${fanImageMap[_myDataController.myChoicechannel.value]}.png'),
              ),
            ),
            SizedBox(
              width: _screenController.screenSize.value.getWidthPerSize(2),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _myDataController.myName.value,
                    style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                        fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: _screenController.screenSize.value.getWidthPerSize(2),
                      ),
                      child: Text(
                        formatToCurrency(_myDataController.myTotalMoney.value),
                        style: TextStyle(
                          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(6),
              width: _screenController.screenSize.value.getHeightPerSize(6),
              child: rankingChangeWidget(
                  _myDataController.myRank.value, _myDataController.myBeforeRank.value),
            ),
          ],
        ),
      ),
    );
  }
}

// 랭킹 리스트에 사용되는 랭킹 데이터 위젯
class RankingWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final RankingDataClass rankingData;
  RankingWidget({super.key, required this.rankingData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenController.screenSize.value.getHeightPerSize(8),
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
          left: _screenController.screenSize.value.getWidthPerSize(2),
          right: _screenController.screenSize.value.getWidthPerSize(2),
        ),
        child: Row(
          children: [
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(8),
              width: _screenController.screenSize.value.getHeightPerSize(4),
              child: Center(
                child: Text(
                  rankingData.rank.toString(),
                  style: GoogleFonts.barlowCondensed(
                    fontWeight: FontWeight.w800,
                    fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                  ),
                ),
              ),
            ),
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(6),
              width: _screenController.screenSize.value.getHeightPerSize(6),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child:
                    Image.asset('assets/image/fan/${fanImageMap[rankingData.choiceChannel]}.png'),
              ),
            ),
            SizedBox(
              width: _screenController.screenSize.value.getWidthPerSize(2),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rankingData.name,
                    style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                        fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: _screenController.screenSize.value.getWidthPerSize(2),
                      ),
                      child: Text(
                        formatToCurrency(rankingData.totalMoney),
                        style: TextStyle(
                          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(6),
              width: _screenController.screenSize.value.getHeightPerSize(6),
              child: rankingChangeWidget(rankingData.rank, rankingData.beforeRank),
            ),
          ],
        ),
      ),
    );
  }
}

// 랭킹 변동 표시 위젯
Widget rankingChangeWidget(int rank, int beforeRank) {
  final ScreenController screenController = Get.find<ScreenController>();
  String title = '-';
  Color color = Colors.black;
  Color iconColor = Colors.black;
  IconData icon = Icons.horizontal_rule;
  if (beforeRank == 0 && rank == 0) {
    title = '-';
    color = Colors.black;
    iconColor = Colors.black;
    icon = Icons.add;
  } else if (beforeRank == 0) {
    title = 'NEW!';
    color = Colors.yellow;
    icon = Icons.add;
  } else if (rank < beforeRank) {
    title = '${beforeRank - rank}';
    color = Colors.black;
    iconColor = Colors.red;
    icon = Icons.arrow_drop_up;
  } else if (rank > beforeRank) {
    title = '${rank - beforeRank}';
    color = Colors.black;
    iconColor = Colors.blue;
    icon = Icons.arrow_drop_down;
  } else {
    title = '-';
    color = Colors.black;
    iconColor = Colors.black;
    icon = Icons.add;
  }

  return Row(
    mainAxisAlignment: icon != Icons.add ? MainAxisAlignment.start : MainAxisAlignment.center,
    children: [
      icon != Icons.add
          ? Icon(
              icon,
              color: iconColor,
            )
          : const SizedBox.shrink(),
      Text(
        title,
        style: TextStyle(
          fontSize: screenController.screenSize.value.getHeightPerSize(2),
          color: color,
        ),
      ),
    ],
  );
}
