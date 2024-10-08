import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoginFailDialog() {
  Get.dialog(
    AlertDialog(
      title: const Text('로그인 실패'),
      content: const Text('입력하신 정보가 일치하지 않습니다.\n다시 시도해 주세요.'),
      //actionsPadding: const EdgeInsets.all(0), // 패딩 없애기
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Get.back(); // 다이얼로그 닫기
            },
            child: const Text('확인'),
          ),
        ),
      ],
    ),
  );
}
