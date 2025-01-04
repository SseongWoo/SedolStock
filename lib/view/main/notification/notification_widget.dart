import 'package:flutter/material.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../viewmodel/main/notification_view_model.dart';

// 상장폐지 메세지 위젯
class NotificationWidget extends StatelessWidget {
  final NotificationViewModel viewModel;
  final int index;
  const NotificationWidget({super.key, required this.viewModel, required this.index});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    return Padding(
      padding: EdgeInsets.all(screenSize.getWidthPerSize(1)),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(screenSize.getWidthPerSize(2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '상장폐지 알림',
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(2)),
                  ),
                  SizedBox(
                    height: screenSize.getHeightPerSize(1),
                  ),
                  Text(
                    viewModel.convertMessage(viewModel.myDataController.messageList[index].itemUID,
                        viewModel.myDataController.messageList[index].stockCount),
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
                  ),
                  SizedBox(
                    height: screenSize.getHeightPerSize(1),
                  ),
                  Text(
                    viewModel.myDataController.messageList[index].time,
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(1), color: Colors.grey),
                  ),
                ],
              )),
              IconButton(
                onPressed: () => viewModel.deleteMessage(index),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
