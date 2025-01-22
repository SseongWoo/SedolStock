import 'package:desktop_window/desktop_window.dart';
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

  // 화면 사이즈 업데이트
  void updateScreenSize(BuildContext context) {
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    // screenSize.value =
    //     ScreenSize(Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height));
    screenSize.value = ScreenSize(Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - viewPadding.bottom));
  }
}

// 해상도에 따른 창 크기 설정 함수
Future<Size> setResolution(String resolution) async {
  double aspectRatio = 19.5 / 9; // iPhone 15 비율
  Size newSize;

  switch (resolution) {
    case 'HD':
      newSize = Size(600, 1280);
      break;
    case 'FHD': // 1080x1920 (iPhone 15 비율)
      newSize = Size(900, 1920);
      break;
    case 'QHD': // 1440x2560 (iPhone 15 비율)
      newSize = Size(1200, 2560);
      break;
    case 'UHD': // 2160x3840 (iPhone 15 비율)
      newSize = Size(1500, 3840);
      break;
    default:
      newSize = Size(900, 1920); // 기본값: FHD
  }

  // await DesktopWindow.setWindowSize(newSize);
  // await DesktopWindow.setMinWindowSize(newSize);
  // await DesktopWindow.setMaxWindowSize(newSize);
  return newSize;
}

void switchResolution(String resolutions) async {
  final size = await setResolution(resolutions);

  await DesktopWindow.setWindowSize(size);
  await DesktopWindow.setMinWindowSize(size);
  await DesktopWindow.setMaxWindowSize(size);

  print('해상도가 ${resolutions} ${size.height}:${size.width}로 변경되었습니다.');

  Size newSize = await DesktopWindow.getWindowSize();
  if (size != newSize) {
    final size = await setResolution('HD');

    await DesktopWindow.setWindowSize(size);
    await DesktopWindow.setMinWindowSize(size);
    await DesktopWindow.setMaxWindowSize(size);
    print('해상도가 맞지않아 롤백합니다');
  }
}
