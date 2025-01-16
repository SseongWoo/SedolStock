import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/view/main/ranking/ranking_widget.dart';
import 'package:stockpj/viewmodel/main/ranking_view_model.dart';
import '../../../constants/color_constants.dart';
import '../../../data/public_data.dart';
import '../../../utils/format.dart';
import '../../../utils/set_myRank.dart';

// 랭킹 화면
class RankingScreen extends StatelessWidget {
  final RankingViewModel _viewModel = Get.put(RankingViewModel());
  RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Obx(
      () {
        final textColor = _viewModel.textColor.value;
        final myTextColor = _viewModel.myDataController.myChoicechannel.value == '박쥐단'
            ? Colors.white
            : Colors.black;
        return Container(
          color: _viewModel.backgroundColor.value,
          child: Padding(
            padding: EdgeInsets.only(
              left: screenSize.getWidthPerSize(2),
              right: screenSize.getWidthPerSize(2),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.getHeightPerSize(4),
                  child: Obx(
                    () => Row(
                      children: [
                        GestureDetector(
                          onTap: () => setMyRank(
                              _viewModel.myDataController, _viewModel.publicDataController),
                          child: Text(
                            '${_viewModel.publicDataController.updateDate.value} 기준',
                            style: TextStyle(
                                fontSize: screenSize.getHeightPerSize(1.4), color: textColor),
                          ),
                        ),
                        const Spacer(),
                        _categoryButton(screenSize, () => _viewModel.showCategoryDialog(true),
                            _viewModel.selectCategoryLargeItem.value, textColor),
                        SizedBox(
                          width: screenSize.getWidthPerSize(4),
                        ),
                        _categoryButton(screenSize, () => _viewModel.showCategoryDialog(false),
                            _viewModel.selectCategorySmallItem.value, textColor),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => RankingTapScreen(
                      screenSize: screenSize,
                      rankingColor: (rank) => _viewModel.rankingColor(rank),
                      rankingList: _viewModel.publicDataController
                          .rankingMap[_viewModel.selectCategorySmallItem.value]!,
                      backgroundColor: _viewModel.backgroundColor.value,
                      textColor: textColor,
                    ),
                  ),
                ),
                Container(
                  height: screenSize.getHeightPerSize(10),
                  decoration: BoxDecoration(
                    color: _viewModel.myRankingColor(),
                    border: Border.all(color: colorSUB),
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
                            child: AutoSizeText(
                              _viewModel.myRankingChange(),
                              style: TextStyle(
                                fontSize: screenSize.getHeightPerSize(3),
                                color: myTextColor,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Container(
                          height: screenSize.getHeightPerSize(6),
                          width: screenSize.getHeightPerSize(6),
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: Image.asset(
                                'assets/image/fan/${fanImageMap[_viewModel.myDataController.myChoicechannel.value]}.png',
                                errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/image/image_error.png');
                            }),
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
                                    fontWeight: FontWeight.bold,
                                    color: myTextColor),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: screenSize.getWidthPerSize(2),
                                  ),
                                  child: Text(
                                    '${formatToCurrency(_viewModel.myDataController.myTotalMoney.value)} P',
                                    style: TextStyle(
                                      fontSize: screenSize.getHeightPerSize(1.8),
                                      color: myTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _categoryButton(ScreenSize screenSize, VoidCallback onPressed, String title, Color color) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(
            Icons.tune,
            size: screenSize.getHeightPerSize(2),
            color: color,
          ),
          Text(
            title,
            style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6), color: color),
          ),
        ],
      ),
    );
  }
}
