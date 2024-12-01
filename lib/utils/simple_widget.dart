import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 커스텀 다이얼로그 위젯
void showSimpleDialog(Function function, String title, String content) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () => function(),
            child: const Text('확인'),
          ),
        ),
      ],
    ),
  );
}

// 커스텀 스낵바 위젯
void showSimpleSnackbar(String title, String content, SnackPosition position, Color textColor) {
  Get.snackbar(
    title,
    content,
    snackPosition: position,
    colorText: textColor,
    duration: const Duration(seconds: 3),
  );
}

// 커스텀 뒤로가기 버튼 위젯
class SimpleBackButtonWidget extends StatelessWidget {
  final Function function;
  const SimpleBackButtonWidget({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => function(),
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }
}
