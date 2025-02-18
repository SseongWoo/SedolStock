import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stockpj/viewmodel/main/information/delete_account_view_model.dart';
import 'package:stockpj/widget/KeyBoardMouseEvent.dart';

// 회원 탈퇴 화면
class DeleteAccountScreen extends StatelessWidget {
  final DeleteAccountViewModel _viewModel = Get.put(DeleteAccountViewModel());
  DeleteAccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return keyBoardMouseEvent(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              _viewModel.screenController.screenSize.value.getWidthPerSize(5),
              0,
              _viewModel.screenController.screenSize.value.getWidthPerSize(5),
              0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '회원 탈퇴',
                style: TextStyle(
                  fontSize: _viewModel.screenController.screenSize.value.getHeightPerSize(3),
                ),
              ),
              SizedBox(
                height: _viewModel.screenController.screenSize.value.getHeightPerSize(2),
              ),
              Text(
                '정말 회원 탈퇴를 진행하시겠습니까?\n탈퇴 시 모든 계정 정보와 데이터가 삭제되며 복구가 불가능합니다.\n회원 탈퇴에 동의하시면, 아래 ‘동의합니다’ 체크박스를 선택해 주세요.',
                style: TextStyle(
                  fontSize: _viewModel.screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
              SizedBox(
                height: _viewModel.screenController.screenSize.value.getHeightPerSize(2),
              ),
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.blue,
                      value: _viewModel.checkBox.value,
                      onChanged: (value) {
                        _viewModel.checkBox.value = !_viewModel.checkBox.value;
                      },
                    ),
                    Text(
                      '회원탈퇴에 동의합니다.',
                      style: TextStyle(
                          fontSize:
                              _viewModel.screenController.screenSize.value.getHeightPerSize(1.8),
                          color: _viewModel.checkBox.value ? Colors.blue : Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _viewModel.screenController.screenSize.value.getHeightPerSize(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(), backgroundColor: Colors.white),
                    onPressed: () {
                      _viewModel.cencel();
                    },
                    child: const Text(
                      '취소',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: _viewModel.screenController.screenSize.value.getWidthPerSize(4),
                  ),
                  Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          backgroundColor: _viewModel.checkBox.value ? Colors.blue : Colors.grey),
                      onPressed: () {
                        _viewModel.startDeleteAccount();
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
      ),
    );
  }
}
