import 'package:flutter/material.dart';
import '../utils/screen_size.dart';

// 버튼 사이 구분선 위젯
Widget settingDivider(
  ScreenSize screenSize,
) {
  return Divider(
    indent: screenSize.getWidthPerSize(4),
    endIndent: screenSize.getWidthPerSize(4),
    color: Colors.grey, // 경계선 색상
    thickness: 0.5, // 경계선 두께
    height: 0, // 경계선 위아래 여백
  );
}

// 버튼 사이 세로 구분선 위젯
Widget settingVerticalDivider(
  ScreenSize screenSize,
) {
  return VerticalDivider(
    thickness: 0.5, // 구분선 두께
    color: Colors.grey, // 구분선 색상
    indent: screenSize.getHeightPerSize(1), // 구분선 위쪽 여백
    endIndent: screenSize.getHeightPerSize(1), // 구분선 아래쪽 여백
  );
}
