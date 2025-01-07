import 'package:flutter/material.dart';
import 'package:stockpj/utils/screen_size.dart';

// 팬덤 선택 위젯
class SignupChoiceFandomWidget extends StatelessWidget {
  final ScreenSize screenSize;
  final Function onPressedLeft;
  final Function onPressedRight;
  final String labelText;
  final Color labelColor;
  const SignupChoiceFandomWidget(
      {super.key,
      required this.screenSize,
      required this.onPressedLeft,
      required this.onPressedRight,
      required this.labelText,
      required this.labelColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: screenSize.getHeightPerSize(2),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '나는',
              style: TextStyle(
                fontSize: screenSize.getHeightPerSize(3),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => onPressedLeft(),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              Expanded(
                child: Text(
                  labelText,
                  style: TextStyle(fontSize: screenSize.getHeightPerSize(4), color: labelColor),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () => onPressedRight(),
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '입니다',
              style: TextStyle(
                fontSize: screenSize.getHeightPerSize(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
