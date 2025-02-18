import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stockpj/constants/color_constants.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/screen_size.dart';
import '../../../viewmodel/main/event_view_model.dart';

// 이벤트 화면
class EventScreen extends StatelessWidget {
  final EventViewModel _viewModel = Get.put(EventViewModel());
  EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (value) {
        // 키보드 이벤트
        if (value is KeyDownEvent) {
          if (value.physicalKey.usbHidUsage == 0x000700e3 ||
              value.logicalKey == LogicalKeyboardKey.backspace ||
              value.logicalKey == LogicalKeyboardKey.escape) {
            Get.back();
          }
        }
      },
      child: DefaultTabController(
        initialIndex: 1,
        length: 3, // 탭의 개수
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              '이벤트',
              style: TextStyle(
                  fontSize: _viewModel.screenController.screenSize.value.getHeightPerSize(2.5)),
            ),
            bottom: TabBar(
              labelColor: colorSUB,
              unselectedLabelColor: Colors.grey,
              indicatorColor: colorSUB,
              tabs: [
                Tab(
                  text: '${_viewModel.eventStatusList[0]} 이벤트',
                  height: _viewModel.screenController.screenSize.value.getHeightPerSize(2.2),
                ),
                Tab(
                  text: '${_viewModel.eventStatusList[1]} 이벤트',
                  height: _viewModel.screenController.screenSize.value.getHeightPerSize(2.2),
                ),
                Tab(
                  text: '${_viewModel.eventStatusList[2]} 이벤트',
                  height: _viewModel.screenController.screenSize.value.getHeightPerSize(2.2),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _eventListScreen(screenSize, _viewModel.publicDataController.eventMap['upcoming']!,
                  _viewModel.eventStatusList[0]),
              _eventListScreen(screenSize, _viewModel.publicDataController.eventMap['ongoing']!,
                  _viewModel.eventStatusList[1]),
              _eventListScreen(screenSize, _viewModel.publicDataController.eventMap['completed']!,
                  _viewModel.eventStatusList[2]),
            ],
          ),
        ),
      ),
    );
  }

  // 이벤트 탭 화면
  Widget _eventListScreen(ScreenSize screenSize, List<EventClass> eventList, String text) {
    return eventList.isNotEmpty
        ? ListView.builder(
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              final event = eventList[index];
              return _eventListItemWidget(screenSize, event);
            },
          )
        : Center(
            child: Text('$text 이벤트가 없습니다.'),
          );
  }

  // 이벤트 리스트 아이템 위젯
  Widget _eventListItemWidget(ScreenSize screenSize, EventClass eventItem) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
      child: Padding(
        padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventItem.title,
              style:
                  TextStyle(fontSize: screenSize.getHeightPerSize(2), fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(1),
            ),
            // const Text(
            //   '대상 채널: ',
            // ),
            // _viewModel.channelText(eventItem.channel),
            Row(
              children: [
                const Text(
                  '대상 채널: ',
                ),
                _viewModel.channelText(eventItem.channel),
              ],
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(2),
            ),
            Text(
              eventItem.description,
              style: TextStyle(
                fontSize: screenSize.getHeightPerSize(1.6),
              ),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(1),
            ),
            Text(
              '이벤트 기간 : ${eventItem.eventStart} ~ ${eventItem.eventEnd}',
              style: TextStyle(
                fontSize: screenSize.getHeightPerSize(1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
