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
