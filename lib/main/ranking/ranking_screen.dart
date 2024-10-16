import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockpj/main/ranking/ranking_widget.dart';
import 'package:stockpj/utils/color.dart';
import '../../utils/screen_size.dart';

class RankingScreen extends StatelessWidget {
  final ScreenController _screenController = Get.put(ScreenController());
  RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Container(
      color: colorStelLiveLight,
      child: Padding(
        padding: EdgeInsets.only(
            left: _screenController.screenSize.value.getWidthPerSize(2),
            right: _screenController.screenSize.value.getWidthPerSize(2)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '부자 랭킹',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
                  ),
                ),
                Text(
                  '10월 11일 01시 00분 기준',
                  style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.2),
                      color: Colors.grey[700]),
                )
              ],
            ),
            Expanded(
                child: Container(
              color: Colors.amberAccent,
            )),
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: _screenController.screenSize.value.getWidthPerSize(2),
                    right: _screenController.screenSize.value.getWidthPerSize(2)),
                child: Row(
                  children: [
                    Container(
                      height: _screenController.screenSize.value.getHeightPerSize(8),
                      width: _screenController.screenSize.value.getHeightPerSize(4),
                      color: Colors.blueAccent,
                      child: Center(
                        child: Text(
                          '100',
                          style: GoogleFonts.barlowCondensed(
                              fontWeight: FontWeight.w800,
                              fontSize: _screenController.screenSize.value.getHeightPerSize(3)),
                        ),
                      ),
                    ),
                    Container(
                      height: _screenController.screenSize.value.getHeightPerSize(6),
                      width: _screenController.screenSize.value.getHeightPerSize(6),
                      color: Colors.orangeAccent,
                    ),
                    SizedBox(
                      width: _screenController.screenSize.value.getWidthPerSize(2),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.image),
                              Text(
                                '닉네임',
                                style: TextStyle(
                                    fontSize:
                                        _screenController.screenSize.value.getHeightPerSize(2)),
                              ),
                            ],
                          ),
                          Text(
                            '보유 총 잔고',
                            style: TextStyle(
                                fontSize: _screenController.screenSize.value.getHeightPerSize(1.8)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: _screenController.screenSize.value.getHeightPerSize(6),
                      width: _screenController.screenSize.value.getHeightPerSize(6),
                      color: Colors.orangeAccent,
                      child: Center(
                        child: Text(
                          '-',
                          style: TextStyle(
                            fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            RankingMyWidget(),
          ],
        ),
      ),
    );
  }
}
