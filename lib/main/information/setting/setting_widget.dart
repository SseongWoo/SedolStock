import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/screen_size.dart';
import '../information_system.dart';

class SettingButtonWidget extends StatelessWidget {
  final String title;
  final Function function;
  const SettingButtonWidget({super.key, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
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
}

class ReStartDialog extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final InformationController _informationController = Get.find<InformationController>();
  ReStartDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('파산 신청'),
      content: Text(
        '파산 신청을 진행하시겠습니까?\n파산을 신청하면 모든 데이터가 초기화되며, 자동으로 로그아웃됩니다. 이 작업은 되돌릴 수 없으니 신중하게 결정해 주세요.',
        style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.8)),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () async {
            Get.back();
            await _informationController.restartUserData();
          },
          child: const Text('파산'),
        ),
      ],
    );
  }
}

Widget settingDivider() {
  final ScreenController screenController = Get.find<ScreenController>();
  return Divider(
    indent: screenController.screenSize.value.getWidthPerSize(4),
    endIndent: screenController.screenSize.value.getWidthPerSize(4),
    color: Colors.grey, // 경계선 색상
    thickness: 0.5, // 경계선 두께
    height: 0, // 경계선 위아래 여백
  );
}
