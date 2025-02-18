import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

Widget keyBoardMouseEvent({required Widget child}){
  return KeyboardListener(focusNode: FocusNode(), autofocus: true,onKeyEvent: (value) {
    // 키보드 이벤트
    if (!EasyLoading.isShow && value is KeyDownEvent) {
      if (value.logicalKey == LogicalKeyboardKey.backspace ||
          value.logicalKey == LogicalKeyboardKey.escape) {
        Get.back();
      }
    }
  }, child: Listener(
    onPointerDown: (event) {
      if(!EasyLoading.isShow && event.buttons == 8){
        Get.back();
      }
    },
    child: child,
  ),
  );
}