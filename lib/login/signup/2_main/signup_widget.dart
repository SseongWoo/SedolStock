import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/2_main/signup_system.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';

class SignUpBackWidget extends StatelessWidget {
  const SignUpBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SingUpEmailControll _singUpControll = Get.find<SingUpEmailControll>();

    return IconButton(
        onPressed: () {
          _singUpControll.backSignUp();
        },
        icon: const Icon(Icons.arrow_back_ios_new));
  }
}

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final ScreenController _screenController = Get.find<ScreenController>();
  final SingUpEmailControll _singUpControll = Get.find<SingUpEmailControll>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _singUpControll.formKey,
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getWidthPerSize(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _singUpControll.controllerID,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: _singUpControll.email ? '이메일 아이디' : '아이디'),
              textInputAction: TextInputAction.next,
              maxLines: 1,
              maxLength: 20,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '값을 입력해 주세요';
                }
                if (value.length < 5) {
                  return '5글자 이상 입력해 주세요';
                }
                if (!_singUpControll.email &&
                    RegExp(r'[!@#$%^&*(),.?":{}|<>~`+=_-]').hasMatch(value)) {
                  return '아이디에 특수 문자는 사용할 수 없습니다.';
                }
                return null; // 유효한 경우 null을 반환
              },
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            TextFormField(
              controller: _singUpControll.controllerPassword,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: '비밀번호'),
              textInputAction: TextInputAction.next,
              maxLines: 1,
              maxLength: 20,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              validator: (value) {
                if (value!.isEmpty) {
                  return '비밀번호를 입력해 주세요';
                }
                if (value.length < 6) {
                  return '비밀번호를 여섯글자 이상 입력해 주세요';
                }
                if (value.trim() != _singUpControll.controllerPasswordCheck.text.trim()) {
                  print(
                      '${_singUpControll.controllerPassword.text}, ${_singUpControll.controllerPasswordCheck.text}');
                  return '비밀번호가 동일하지 않습니다.';
                }
                return null;
              },
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            TextFormField(
              controller: _singUpControll.controllerPasswordCheck,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: '비밀번호 확인'),
              textInputAction: TextInputAction.next,
              maxLines: 1,
              maxLength: 20,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '값을 입력해 주세요';
                }
                if (value.length < 5) {
                  return '5글자 이상 입력해 주세요';
                }
                return null; // 유효한 경우 null을 반환
              },
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            SignUpButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class SignUpButtonWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final SingUpEmailControll _singUpControll = Get.find<SingUpEmailControll>();
  SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // 기기의 전체 너비
      child: ElevatedButton(
        onPressed: () {
          if (_singUpControll.formKey.currentState!.validate()) {
            _singUpControll.trySignUp();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorStelLiveLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          '회원가입',
          style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
        ),
      ),
    );
  }
}
