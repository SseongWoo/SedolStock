import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/signup_system.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';

class SignupCheckemailScreen extends StatelessWidget {
  SignupCheckemailScreen({super.key});

  final ScreenController _screenController = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    final String email = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorStelLive,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text('회원가입'),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          _screenController.screenSize.value.getHeightPerSize(3),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                '이메일 주소 인증',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(3),
              ),
              Text(
                '$email님,\n\n인증 이메일을 발송했습니다. 메일을 확인하시고 링크를 클릭하여 인증을 완료해 주세요. 감사합니다.',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(5),
              ),
              SizedBox(
                width: _screenController.screenSize.value.getWidthPerSize(50),
                child: ElevatedButton(
                  onPressed: () {
                    goSignUpSetProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorStelLiveLight, // 버튼 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // 버튼을 둥글게 만들어 FAB 느낌을 줌
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이를 조절
                  ),
                  child: const Text(
                    '이메일 주소 인증 완료',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(5),
              ),
              const Divider(
                color: Colors.grey, // 구분선 색상
                thickness: 1, // 구분선 두께
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '메일이 도착하지 않았나요? 다시 전송하시겠습니까?',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.3),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '재전송',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1.3),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
