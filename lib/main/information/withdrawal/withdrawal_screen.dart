import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/withdrawal/withdrawal_system.dart';
import '../../../utils/screen_size.dart';

// 회원 탈퇴 화면
class WithdrawalScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final WithdrawalController _withdrawalController = Get.put(WithdrawalController());
  WithdrawalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(_screenController.screenSize.value.getWidthPerSize(5), 0,
            _screenController.screenSize.value.getWidthPerSize(5), 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '회원 탈퇴',
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(3),
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            Text(
              '정말 회원 탈퇴를 진행하시겠습니까?\n탈퇴 시 모든 계정 정보와 데이터가 삭제되며 복구가 불가능합니다.\n회원 탈퇴에 동의하시면, 아래 ‘동의합니다’ 체크박스를 선택해 주세요.',
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            Obx(
              () => Row(
                children: [
                  Checkbox(
                    activeColor: Colors.blue,
                    value: _withdrawalController.checkBox.value,
                    onChanged: (value) {
                      _withdrawalController.checkBox.value = !_withdrawalController.checkBox.value;
                    },
                  ),
                  Text(
                    '회원탈퇴에 동의합니다.',
                    style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                        color: _withdrawalController.checkBox.value ? Colors.blue : Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(), backgroundColor: Colors.white),
                  onPressed: () {
                    _withdrawalController.cencel();
                  },
                  child: const Text(
                    '취소',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: _screenController.screenSize.value.getWidthPerSize(4),
                ),
                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor:
                            _withdrawalController.checkBox.value ? Colors.blue : Colors.grey),
                    onPressed: () {
                      _withdrawalController.startDelete();
                    },
                    child: const Text(
                      '회원 탈퇴',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
