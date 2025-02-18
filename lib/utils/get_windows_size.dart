import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:win32/win32.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/storage_service.dart';

// 데스크탑 모드일시 윈도우 디스플레이 크기를 가져오는 함수
Size getPhysicalScreenSize() {
  if (GetPlatform.isDesktop) {
    final hdc = GetDC(0);
    final width = GetDeviceCaps(hdc, GET_DEVICE_CAPS_INDEX.HORZRES);
    final height = GetDeviceCaps(hdc, GET_DEVICE_CAPS_INDEX.VERTRES);
    ReleaseDC(0, hdc);

    return Size(width.toDouble(), height.toDouble());
  } else {
    throw UnsupportedError('This function is only supported on Windows');
  }
}

// 데스크탑 모드일시 창 크기를 조절하는 함수
void setWindowsSize(int percent) async {
  final ScreenController screenController = Get.find<ScreenController>();

  double targetHeight = screenController.windowsMaxSize.height * (percent / 100);
  double targetWidth = targetHeight * (10 / 19);
  EasyLoading.show();
  screenController.setWindowSizeList(screenController.windowsMaxSize.height);
  await DesktopWindow.setWindowSize(Size(targetWidth, targetHeight));
  await DesktopWindow.setMaxWindowSize(Size(targetWidth, targetHeight));
  await DesktopWindow.setMinWindowSize(Size(targetWidth, targetHeight));
  EasyLoading.dismiss();
  saveWindowsSizeData(percent);
  screenController.sizePer.value = percent;
}
