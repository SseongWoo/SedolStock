import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/main_system.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../utils/timer.dart';

import 'main_widget.dart';

// 메인 화면
class MainScreen extends StatelessWidget {
  final MainController _homeController = Get.put(MainController());
  final ScreenController _screenController = Get.find<ScreenController>();
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 모든 화면이 빌드 후 실행되게 하는 기능
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
        appBar: AppBar(
          leading: LeadingWidget(),
          title: Obx(
            () => Text(_homeController.pagesName[_homeController.selectedIndex.value]),
          ),
          actions: [
            Padding(
              padding:
                  EdgeInsets.only(right: _screenController.screenSize.value.getWidthPerSize(2)),
              child: TimerWidget(),
            ),
          ],
        ),
        body: Obx(() => _homeController.pages[_homeController.selectedIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: colorISEGYEIDOL, // 바탕색
            selectedItemColor: Colors.white, // 선택된 항목 색상
            unselectedItemColor: colorISEGYEIDOLLight, // 선택되지 않은 항목 색상
            type: BottomNavigationBarType.fixed, // 모든 탭에 색상 적용

            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: '거래'),
              BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: '랭킹'),
              BottomNavigationBarItem(icon: Icon(Icons.wallet), label: '지갑'),
              BottomNavigationBarItem(icon: Icon(Icons.info), label: '정보'),
            ],
            currentIndex: _homeController.selectedIndex.value,
            onTap: (int i) => _homeController.changeTabIndex(i),
          ),
        ));
  }
}
