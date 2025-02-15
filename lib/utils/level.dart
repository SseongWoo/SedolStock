import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/widget/simple_widget.dart';

int getLevelImage(int level) {
  if (level > 21) level = 21;
  if (level <= 0) level = 0;

  return level;
}

void levelUPDialog(ScreenSize screenSize, int level) {
  int fixLevel = level < 1 ? 1 : level;
  showSimpleDialog2(
      screenSize,
      '레벨업!',
      '축하합니다! 총 보유 금액 100억을 달성했습니다. 잔고가 초기화되며, 레벨이 상승합니다!\n\n${fixLevel - 1} → $fixLevel',
      Get.back);
}
