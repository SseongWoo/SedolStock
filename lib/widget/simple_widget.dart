import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/screen_size.dart';

import '../constants/color_constants.dart';
import 'button.dart';

// 커스텀 다이얼로그 위젯
void showSimpleDialog(Function function, String title, String content) {
  Get.dialog(
    AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorMAIN,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 버튼 모서리 둥글기 설정
              ),
            ),
            onPressed: () => function(),
            child: const Text('확인'),
          ),
        ),
      ],
    ),
  );
}

void showSimpleDialog2(ScreenSize screenSize, String title, String content, Function function) {
  Get.dialog(
    Center(
      child: Container(
        height: screenSize.getHeightPerSize(30),
        width: screenSize.getWidthPerSize(80),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(
            screenSize.getHeightPerSize(2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(2),
                ),
              ),
              const Spacer(),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(1.8),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: screenSize.getHeightPerSize(6),
                width: screenSize.getWidthPerSize(80),
                child: Expanded(
                  child: dialogButton(
                    screenSize,
                    '확인',
                    colorMAIN,
                    function,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void showSimpleDialog3(
    ScreenSize screenSize, String title, String content, String buttonText, Function function) {
  Get.dialog(
    Center(
      child: Container(
        height: screenSize.getHeightPerSize(26),
        width: screenSize.getWidthPerSize(80),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(
            screenSize.getHeightPerSize(2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(2),
                ),
              ),
              const Spacer(),
              Text(
                content,
                style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(1.8),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: screenSize.getHeightPerSize(6),
                width: screenSize.getWidthPerSize(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: dialogButton(
                        screenSize,
                        '취소',
                        Colors.white,
                        Get.back,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.getHeightPerSize(2),
                    ),
                    Expanded(
                      child: dialogButton(
                        screenSize,
                        '확인',
                        colorMAIN,
                        function,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// 커스텀 스낵바 위젯
void showSimpleSnackbar(String title, String content, SnackPosition position, Color textColor) {
  Get.snackbar(
    title,
    content,
    snackPosition: position,
    colorText: textColor,
    duration: const Duration(seconds: 3),
  );
}
