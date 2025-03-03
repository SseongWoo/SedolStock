import 'package:flutter/material.dart';
import 'package:stockpj/model/data/data_class.dart';
import 'package:stockpj/utils/screen_size.dart';

// 상장폐지 메세지 위젯
class NotificationWidget extends StatelessWidget {
  final MessageClass messageData;
  final VoidCallback onDelete;
  final ScreenSize screenSize;
  final String messageContent;
  final String messageTitle;

  const NotificationWidget({
    super.key,
    required this.onDelete,
    required this.messageData,
    required this.screenSize,
    required this.messageContent,
    required this.messageTitle,
  });

  @override
  Widget build(BuildContext context) {
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
                    messageTitle,
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(2)),
                  ),
                  SizedBox(
                    height: screenSize.getHeightPerSize(1),
                  ),
                  Text(
                    messageContent,
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
                  ),
                  SizedBox(
                    height: screenSize.getHeightPerSize(1),
                  ),
                  Text(
                    messageData.time,
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(1), color: Colors.grey),
                  ),
                ],
              )),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
