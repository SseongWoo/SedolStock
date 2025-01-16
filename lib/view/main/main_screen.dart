import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/color_constants.dart';
import '../../data/my_data.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';
import 'package:badges/badges.dart' as badges;
import '../../utils/timer.dart';
import '../../viewmodel/main/main_view_model.dart';

// 메인 화면
class MainScreen extends StatelessWidget {
  final MainViewModel _viewModel = Get.put(MainViewModel());
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _screenController.updateScreenSize(context);
    // });
    return Scaffold(
      appBar: AppBar(
        leading: Obx(
          () => Center(
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(
                top: _screenController.screenSize.value.getHeightPerSize(1.4),
                end: _screenController.screenSize.value.getWidthPerSize(3.2),
              ),
              showBadge: _myDataController.messageList.isNotEmpty,
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.red,
                elevation: 4,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  size: _screenController.screenSize.value.getHeightPerSize(4),
                ), // 배지 아래에 아이콘
                onPressed: _viewModel.onPressed,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: Obx(
          () => Text(
            _viewModel.pagesName[_viewModel.selectedIndex.value],
            style: const TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: _screenController.screenSize.value.getWidthPerSize(2)),
            child: TimerWidget(),
          ),
        ],
      ),
      body: Obx(() => _viewModel.pages[_viewModel.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: colorSUB, // 바탕색
          selectedItemColor: colorMAIN, // 선택된 항목 색상
          unselectedItemColor: Colors.white, // 선택되지 않은 항목 색상
          type: BottomNavigationBarType.fixed, // 모든 탭에 색상 적용

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: '거래'),
            BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: '랭킹'),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: '지갑'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: '정보'),
          ],
          currentIndex: _viewModel.selectedIndex.value,
          onTap: (int i) => _viewModel.changeTabIndex(i),
        ),
      ),
    );
  }
}
