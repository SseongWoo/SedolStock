import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 화면 사이즈 클래스
class ScreenSize {
  late Size screenSize;

  ScreenSize(this.screenSize);

  double getHeightSize() {
    return screenSize.height;
  }

  double getWidthSize() {
    return screenSize.width;
  }

  double getHeightPerSize(double per) {
    return (screenSize.height * per) / 100;
  }

  double getWidthPerSize(double per) {
    return (screenSize.width * per) / 100;
  }
}

class ScreenController extends GetxController {
  // 반응형 변수로 ScreenSize를 관리합니다.
  var screenSize = ScreenSize(Size(0.0, 0.0)).obs;

  // 화면 크기를 업데이트하는 메서드
  void updateScreenSize(BuildContext context) {
    screenSize.value =
        ScreenSize(Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height));
  }
}
