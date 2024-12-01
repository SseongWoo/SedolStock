import 'dart:ui';
import 'package:flutter/material.dart';

// 웹에서도 스크롤을 동작하게 하기 위한 기능
class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
      };
}
