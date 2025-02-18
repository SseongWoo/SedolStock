import 'package:flutter/material.dart';
import 'package:stockpj/constants/color_constants.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../widget/button.dart';

class UpdateDialog extends StatelessWidget {
  final ScreenSize screenSize;
  final Function onPressedCencle;
  final Function onPressedUpdate;
  final String appVersion;
  final String newVersion;
  const UpdateDialog(
      {super.key,
      required this.screenSize,
      required this.onPressedCencle,
      required this.onPressedUpdate,
      required this.appVersion,
      required this.newVersion});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: screenSize.getHeightPerSize(28),
        width: screenSize.getWidthPerSize(80),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(
            screenSize.getHeightPerSize(2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '공지',
                style: TextStyle(fontSize: screenSize.getHeightPerSize(2)),
              ),
              const Spacer(),
              Text(
                '게임이 업데이트 되었습니다.\n최신버전 설치 후 이용해주세요\n현재버전 : $appVersion\n최신버전 : $newVersion\n',
                style: TextStyle(fontSize: screenSize.getHeightPerSize(1.8)),
              ),
              const Spacer(),
              SizedBox(
                height: screenSize.getHeightPerSize(6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: dialogButton(
                        screenSize,
                        '취소',
                        Colors.white,
                        onPressedCencle,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.getHeightPerSize(2),
                    ),
                    Expanded(
                      child: dialogButton(screenSize, '업데이트', colorMAIN, onPressedUpdate),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
