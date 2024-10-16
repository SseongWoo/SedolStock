import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/screen_size.dart';

final ScreenController _screenController = Get.put(ScreenController());

class RankingMyWidget extends StatelessWidget {
  const RankingMyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenController.screenSize.value.getHeightPerSize(10),
      decoration: const BoxDecoration(
        color: Colors.greenAccent,
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
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
                            fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
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
                  'new!',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                    color: Colors.yellowAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
