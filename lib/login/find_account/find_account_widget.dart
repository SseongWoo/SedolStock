import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';
import 'find_account_system.dart';

class FindAccountEmailWidget extends StatefulWidget {
  const FindAccountEmailWidget({super.key});

  @override
  State<FindAccountEmailWidget> createState() => _FindAccountEmailWidgetState();
}

class _FindAccountEmailWidgetState extends State<FindAccountEmailWidget> {
  final FindAccountController _findAccountController = Get.find<FindAccountController>();
  final ScreenController _screenController = Get.find<ScreenController>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _findAccountController.formKey,
      child: TextFormField(
        controller: _findAccountController.controllerName,
        decoration: const InputDecoration(labelText: '이메일', border: OutlineInputBorder()),
        maxLines: 1,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        validator: (value) {
          if (value!.isEmpty) {
            return '이메일을 입력해 주세요';
          }
          if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
            return '유효한 이메일 형식이 아닙니다';
          }
          return null;
        },
      ),
    );
  }
}

class FindAccountButtonWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  FindAccountButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FindAccountController _findAccountController = Get.find<FindAccountController>();
    return SizedBox(
      width: double.infinity, // 기기의 전체 너비
      child: ElevatedButton(
        onPressed: () {
          if (_findAccountController.formKey.currentState!.validate()) {
            _findAccountController.sendFindEmail();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorISEGYEIDOLLight, // 버튼 배경색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // 버튼을 둥글게 만들어 FAB 느낌을 줌
          ),
          padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이를 조절
        ),
        child: Text(
          '비밀번호 찾기',
          style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
        ),
      ),
    );
  }
}
