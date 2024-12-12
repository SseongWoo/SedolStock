import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/main/message/message_system.dart';
import '../../utils/screen_size.dart';

// 메세지 위젯 리스트
class MessageListWidget extends StatelessWidget {
  final MyDataController _myDataController = Get.find<MyDataController>();
  final MessageController _messageController = Get.find<MessageController>();
  MessageListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _myDataController.messageList.isNotEmpty
          ? ListView.builder(
              itemCount: _myDataController.messageList.length,
              itemBuilder: (context, index) {
                return MessageWidget(
                  title: '상장폐지 알림',
                  message: _messageController.convertMessage(
                      _myDataController.messageList[index].itemUID,
                      _myDataController.messageList[index].stockCount),
                  time: _myDataController.messageList[index].time,
                  onClose: () {
                    _myDataController.messageList.removeAt(index); // 버튼 클릭 시 해당 메시지 삭제
                  },
                );
              })
          : const Center(
              child: Text('현재 알림이 없습니다.'),
            ),
    );
  }
}

// 메세지 위젯
class MessageWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final String title;
  final String message;
  final String time;
  final VoidCallback onClose;
  MessageWidget(
      {super.key,
      required this.title,
      required this.message,
      required this.onClose,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_screenController.screenSize.value.getWidthPerSize(1)),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(_screenController.screenSize.value.getWidthPerSize(2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
                  ),
                  SizedBox(
                    height: _screenController.screenSize.value.getHeightPerSize(1),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1.6)),
                  ),
                  SizedBox(
                    height: _screenController.screenSize.value.getHeightPerSize(1),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1),
                        color: Colors.grey),
                  ),
                ],
              )),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
