import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/main_system.dart';
import 'package:stockpj/utils/color.dart';

import '../utils/timer.dart';

class MainScreen extends StatelessWidget {
  final MainController _homeController = Get.put(MainController());
  final TimerController _timerController = Get.put(TimerController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              '다음 갱신까지 남은 시간: ${_timerController.timeDisplay.value}',
              style: const TextStyle(fontSize: 24),
            )),
      ),
      body: Obx(() => _homeController.pages[_homeController.selectedIndex.value]),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        color: colorStelLiveLight,
        backgroundColor: colorStelLive,
        items: const [
          TabItem(icon: Icons.home, title: '홈'),
          TabItem(icon: Icons.map, title: '거래'),
          TabItem(icon: Icons.add, title: '랭킹'),
          TabItem(icon: Icons.message, title: '내정보'),
          TabItem(icon: Icons.people, title: '설정'),
        ],
        onTap: (int i) => _homeController.changeTabIndex(i),
      ),
    );
  }
}
