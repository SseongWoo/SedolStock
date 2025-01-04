import 'package:flutter/material.dart';

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
