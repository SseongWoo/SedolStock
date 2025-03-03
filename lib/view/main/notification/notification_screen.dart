import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/model/data/data_class.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/viewmodel/main/notification_view_model.dart';
import 'package:stockpj/widget/KeyBoardMouseEvent.dart';
import 'notification_widget.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationViewModel _viewModel = Get.put(NotificationViewModel());
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return keyBoardMouseEvent(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '알림',
            style: TextStyle(fontSize: screenSize.getHeightPerSize(2.5)),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _viewModel.clearMessage();
                },
                child: Text(
                  '알림 지우기',
                  style: TextStyle(fontSize: screenSize.getHeightPerSize(2.2)),
                ))
          ],
        ),
        body: Obx(
          () => _viewModel.myDataController.messageList.isNotEmpty
              ? ListView.builder(
                  itemCount: _viewModel.myDataController.messageList.length,
                  itemBuilder: (context, index) {
                    MessageClass messageData = _viewModel.myDataController.messageList[index];
                    return NotificationWidget(
                      screenSize: screenSize,
                      messageData: messageData,
                      messageTitle: _viewModel.convertMessageTitle(messageData),
                      messageContent: _viewModel.convertMessageContent(messageData),
                      onDelete: () => _viewModel.deleteMessage(index),
                    );
                  })
              : const Center(
                  child: Text('현재 알림이 없습니다.'),
                ),
        ),
      ),
    );
  }
}
