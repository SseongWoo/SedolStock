import 'package:flutter/material.dart';
import '../utils/screen_size.dart';

// 버튼 사이 구분선 위젯
Widget settingDivider(
  ScreenSize screenSize,
) {
  return Divider(
    indent: screenSize.getWidthPerSize(4),
    endIndent: screenSize.getWidthPerSize(4),
    color: Colors.grey,
    thickness: 0.5,
    height: 0,
  );
}

// 버튼 사이 세로 구분선 위젯
Widget settingVerticalDivider(
  ScreenSize screenSize,
) {
  return VerticalDivider(
    thickness: 0.5,
    color: Colors.grey,
    indent: screenSize.getHeightPerSize(1),
    endIndent: screenSize.getHeightPerSize(1),
  );
}
