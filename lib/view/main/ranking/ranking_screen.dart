import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/view/main/ranking/ranking_widget.dart';
import 'package:stockpj/viewmodel/main/ranking_view_model.dart';

import '../../../data/public_data.dart';
import '../../../utils/format.dart';

// 랭킹 화면
class RankingScreen extends StatelessWidget {
  final RankingViewModel _viewModel = Get.put(RankingViewModel());
  RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          left: screenSize.getWidthPerSize(2),
          right: screenSize.getWidthPerSize(2),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _viewModel.timeText.value,
                style:
                    TextStyle(fontSize: screenSize.getHeightPerSize(1.2), color: Colors.grey[700]),
              ),
            ),
            Expanded(
                child: _viewModel.publicDataController.rankingList.isNotEmpty
                    ? ListView.builder(
                        itemCount: _viewModel.publicDataController.rankingList.length,
                        itemBuilder: (context, index) {
                          final rankingData = _viewModel.publicDataController.rankingList[index];
                          final rankingColor = _viewModel.rankingColor(rankingData.rank);

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
                    : const Center(
                        child: Text('랭킹 데이터를 불러오지 못했습니다.'),
                      )),
            Container(
              height: screenSize.getHeightPerSize(10),
              decoration: BoxDecoration(
                color: _viewModel.myRankingColor(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
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
                          _viewModel.myRankingChange(),
                          style: TextStyle(
                            fontSize: screenSize.getHeightPerSize(_viewModel.myRankingTextSize()),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: screenSize.getHeightPerSize(6),
                      width: screenSize.getHeightPerSize(6),
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: Image.asset(
                            'assets/image/fan/${fanImageMap[_viewModel.myDataController.myChoicechannel.value]}.png'),
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
                            _viewModel.myDataController.myName.value,
                            style: TextStyle(
                                fontSize: screenSize.getHeightPerSize(2),
                                fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: screenSize.getWidthPerSize(2),
                              ),
                              child: Text(
                                formatToCurrency(_viewModel.myDataController.myTotalMoney.value),
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
                      child: rankingChangeWidget(
                          screenSize,
                          _viewModel.myDataController.myRank.value,
                          _viewModel.myDataController.myBeforeRank.value),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
