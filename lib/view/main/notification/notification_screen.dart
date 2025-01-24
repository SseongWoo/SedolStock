import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/viewmodel/main/notification_view_model.dart';
import 'notification_widget.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationViewModel _viewModel = Get.put(NotificationViewModel());
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '알림',
          style: TextStyle(
              fontSize: _viewModel.screenController.screenSize.value.getHeightPerSize(2.5)),
        ),
        actions: [
          TextButton(
              onPressed: () {
                _viewModel.clearMessage();
              },
              child: Text(
                '알림 지우기',
                style: TextStyle(
                    fontSize: _viewModel.screenController.screenSize.value.getHeightPerSize(2.2)),
              ))
        ],
      ),
      body: Obx(
        () => _viewModel.myDataController.messageList.isNotEmpty
            ? ListView.builder(
                itemCount: _viewModel.myDataController.messageList.length,
                itemBuilder: (context, index) {
                  return NotificationWidget(
                    index: index,
                    viewModel: _viewModel,
                  );
                })
            : const Center(
                child: Text('현재 알림이 없습니다.'),
              ),
      ),
    );
  }
}
