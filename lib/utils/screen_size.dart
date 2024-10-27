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

class ScreenController extends GetxController with WidgetsBindingObserver {
  var screenSize = ScreenSize(Size(0.0, 0.0)).obs;

  // @override
  // void onInit() {
  //   WidgetsBinding.instance.addObserver(this);
  //   super.onInit();
  // }
  //
  // @override
  // void onClose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.onClose();
  // }
  //
  // @override
  // void didChangeMetrics() {
  //   if (Get.context != null) {
  //     updateScreenSize(Get.context!);
  //     print('${Get.context!.size?.height}, ${Get.context!.size?.width}');
  //   } else {
  //     print('오류');
  //   }
  // }

  void updateScreenSize(BuildContext context) {
    screenSize.value =
        ScreenSize(Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height));
  }
}
