import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/main_system.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../data/my_data.dart';
import '../utils/timer.dart';

class MainScreen extends StatelessWidget {
  final MainController _homeController = Get.put(MainController());
  final ScreenController _screenController = Get.find<ScreenController>();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(_homeController.pagesName[_homeController.selectedIndex.value]),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: _screenController.screenSize.value.getWidthPerSize(2)),
            child: TimerWidget(),
          ),
        ],
      ),
      body: Obx(() => _homeController.pages[_homeController.selectedIndex.value]),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        color: colorISEGYEIDOLLight,
        backgroundColor: colorISEGYEIDOL,
        items: const [
          TabItem(icon: Icons.home, title: '홈'),
          TabItem(icon: Icons.show_chart, title: '거래'),
          TabItem(icon: Icons.emoji_events, title: '랭킹'),
          TabItem(icon: Icons.wallet, title: '지갑'),
          TabItem(icon: Icons.info, title: '정보'),
        ],
        onTap: (int i) => _homeController.changeTabIndex(i),
      ),
    );
  }
}
