import 'package:flutter/material.dart';
import 'package:stockpj/main/message/message_system.dart';
import 'package:get/get.dart';

import '../../data/my_data.dart';
import '../../utils/screen_size.dart';
import 'message_widget.dart';

class MessageScreen extends StatelessWidget {
  final MessageController _messageController = Get.put(MessageController());
  final ScreenController _screenController = Get.find<ScreenController>();
  MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        actions: [
          TextButton(
              onPressed: () {
                _messageController.clearMessage();
              },
              child: const Text('알림 지우기'))
        ],
      ),
      body: MessageListWidget(),
    );
  }
}
