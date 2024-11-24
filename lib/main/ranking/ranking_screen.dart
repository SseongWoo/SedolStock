import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockpj/main/ranking/ranking_widget.dart';
import 'package:stockpj/utils/color.dart';
import '../../utils/screen_size.dart';

class RankingScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorISEGYEIDOLLight,
      child: Padding(
        padding: EdgeInsets.only(
            left: _screenController.screenSize.value.getWidthPerSize(2),
            right: _screenController.screenSize.value.getWidthPerSize(2)),
        child: Column(
          children: [
            RankingSubTitleWidget(),
            Expanded(child: RankingListViewWidget()),
            RankingMyWidget(),
          ],
        ),
      ),
    );
  }
}
