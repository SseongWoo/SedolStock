import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';
import 'find_account_system.dart';

// 이메일 입력 텍스트 필드 위젯
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

// 계정 찾기 버튼 위젯
class FindAccountButtonWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  FindAccountButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FindAccountController findAccountController = Get.find<FindAccountController>();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (findAccountController.formKey.currentState!.validate()) {
            findAccountController.sendFindEmail();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorISEGYEIDOLLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          '비밀번호 찾기',
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(2),
          ),
        ),
      ),
    );
  }
}
