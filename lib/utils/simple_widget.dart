import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSimpleDialog(Function function, String title, String content) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(content),
      //actionsPadding: const EdgeInsets.all(0), // 패딩 없애기
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

void showSimpleSnackbar(String title, String content, SnackPosition position, Color textColor) {
  Get.snackbar(
    title, // 제목
    content, // 메시지 내용
    snackPosition: position, // 스낵바 위치
    //backgroundColor: Colors.blueAccent, // 배경 색
    colorText: textColor, // 텍스트 색
    duration: const Duration(seconds: 3), // 표시 시간
  );
}

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
