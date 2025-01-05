import 'package:flutter/material.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../data/public_data.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/format.dart';

// 랭킹 리스트에 사용되는 랭킹 데이터 위젯
class RankingWidget extends StatelessWidget {
  final ScreenSize screenSize;
  final RankingDataClass rankingData;
  const RankingWidget({super.key, required this.rankingData, required this.screenSize});

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
                child: Text(
                  rankingData.rank.toString(),
                  style: TextStyle(
                    fontSize: screenSize.getHeightPerSize(rankingData.rank < 100 ? 3 : 2),
                  ),
                ),
              ),
            ),
            Container(
              height: screenSize.getHeightPerSize(6),
              width: screenSize.getHeightPerSize(6),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child:
                    Image.asset('assets/image/fan/${fanImageMap[rankingData.choiceChannel]}.png'),
              ),
            ),
            SizedBox(
              width: screenSize.getWidthPerSize(2),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rankingData.name,
                    style: TextStyle(
                        fontSize: screenSize.getHeightPerSize(2), fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: screenSize.getWidthPerSize(2),
                      ),
                      child: Text(
                        formatToCurrency(rankingData.totalMoney),
                        style: TextStyle(
                          fontSize: screenSize.getHeightPerSize(1.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(6),
              width: screenSize.getHeightPerSize(6),
              child: rankingChangeWidget(screenSize, rankingData.rank, rankingData.beforeRank),
            ),
          ],
        ),
      ),
    );
  }
}

// 랭킹 변동 표시 위젯
Widget rankingChangeWidget(ScreenSize screenSize, int rank, int beforeRank) {
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
          fontSize: screenSize.getHeightPerSize(2),
          color: color,
        ),
      ),
    ],
  );
}
