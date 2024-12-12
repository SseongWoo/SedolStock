import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/main/main_system.dart';
import '../utils/screen_size.dart';

// 알림 아이콘 위젯
class LeadingWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final MainController _mainController = Get.find<MainController>();
  LeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => badges.Badge(
        position: badges.BadgePosition.topEnd(
          top: _screenController.screenSize.value.getHeightPerSize(1.2),
          end: _screenController.screenSize.value.getWidthPerSize(5),
        ),
        showBadge: _myDataController.messageList.isNotEmpty,
        badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.red,
          elevation: 4,
        ),
        child: IconButton(
          icon: const Icon(Icons.notifications_none), // 배지 아래에 아이콘
          onPressed: () {
            _mainController.goMessage();
          },
        ),
      ),
    );
  }
}
