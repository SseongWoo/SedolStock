import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../utils/screen_size.dart';

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

Widget informationButton(String title, Function function) {
  return Container(
    color: Colors.white,
    child: ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        function();
      },
    ),
  );
}

// 다이얼로그 버튼
Widget dialogButton(ScreenSize screenSize, String text, Color backgroundColor, Function onPressed) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      side: const BorderSide(color: colorMAIN, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 버튼 모서리 둥글기 설정
      ),
    ),
    onPressed: () {
      onPressed();
    },
    child: Text(
      text,
      style: TextStyle(
        color: colorSUB,
        fontSize: screenSize.getHeightPerSize(1.6),
      ),
    ),
  );
}
