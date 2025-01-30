import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 화면 사이즈 클래스
class ScreenSize {
  late Size screenSize;
  ScreenSize(this.screenSize);

  // 화면 높이
  double getHeightSize() {
    if (GetPlatform.isWeb && screenSize.height <= 750) {
      return 750;
    } else {
      return screenSize.height;
    }
  }

  // 화면 너비
  double getWidthSize() {
    if (GetPlatform.isWeb) {
      if (screenSize.width <= 500 || screenSize.height <= 750) {
        return 500;
      } else {
        return screenSize.height * (10 / 16);
      }
    } else {
      return screenSize.width;
    }
  }

  // 화면 높이를 원하는 비율로 반환
  double getHeightPerSize(double per) {
    if (GetPlatform.isWeb && screenSize.height <= 750) {
      return (750 * per) / 100;
    } else {
      return (screenSize.height * per) / 100;
    }
  }

  // 화면 너비를 원하는 비율로 반환
  double getWidthPerSize(double per) {
    if (GetPlatform.isWeb) {
      if (screenSize.width <= 500 || screenSize.height <= 750) {
        return (500 * per) / 100;
      } else {
        return (screenSize.height * (10 / 16) * per) / 100;
      }
    } else {
      return (screenSize.width * per) / 100;
    }
  }
}

class ScreenController extends GetxController with WidgetsBindingObserver {
  var screenSize = ScreenSize(const Size(0.0, 0.0)).obs; // 화면 사이즈 변수
  Size windowsMaxSize = const Size(0.0, 0.0);
  RxInt sizePer = 60.obs;
  List<int> windowSizeList = [70, 80, 90];

  // 화면 사이즈 업데이트
  void updateScreenSize(BuildContext context) {
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    // screenSize.value =
    //     ScreenSize(Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height));
    screenSize.value = ScreenSize(Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - viewPadding.bottom));
  }

  // 창 크기 비율을 fhd, qhd, uhd 각각 다르게 설정하는 함수
  void setWindowSizeList(double heightSize) {
    if (heightSize <= 1200) {
      windowSizeList = [70, 80, 90];
    } else if (heightSize <= 1500) {
      windowSizeList = [60, 70, 80, 90];
    } else {
      windowSizeList = [40, 50, 60, 70, 80, 90];
    }
  }
}
