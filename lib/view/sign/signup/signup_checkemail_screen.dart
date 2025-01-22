import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../constants/color_constants.dart';
import '../../../viewmodel/sign/signup_checkemail_view_model.dart';

// 회원가입 이메일 인증 화면
class SignupCheckemailScreen extends StatelessWidget {
  final SignupCheckemailViewModel _viewModel = Get.put(SignupCheckemailViewModel());
  SignupCheckemailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _viewModel.screenController.updateScreenSize(context);
    // });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorMAIN,
        leading: IconButton(
          onPressed: _viewModel.cancelSignUp,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          '회원가입',
          style: TextStyle(
            fontSize: screenSize.getHeightPerSize(2.6),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          screenSize.getHeightPerSize(3),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                '이메일 주소 인증',
                style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(3),
                ), // 밑줄 두께,
                textAlign: TextAlign.center,
              ),
              Divider(
                indent: screenSize.getWidthPerSize(20),
                endIndent: screenSize.getWidthPerSize(20),
                color: Colors.grey, // 경계선 색상
                thickness: 1, // 경계선 두께
                height: 0, // 경계선 위아래 여백
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(3),
              ),
              Text.rich(
                TextSpan(
                  text: _viewModel.id,
                  style: TextStyle(
                    fontSize: screenSize.getHeightPerSize(1.6),
                    fontWeight: FontWeight.bold,
                  ),
                  children: const [
                    TextSpan(
                      text: '님',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(3),
              ),
              Text(
                '인증 이메일을 발송했습니다. 메일을 확인하시고 링크를 클릭하여 인증을 완료해 주세요. 감사합니다.',
                style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(1.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: screenSize.getHeightPerSize(5),
                    child: Image.asset('assets/image/ui/bolt1_dark.png'),
                  ),
                  SizedBox(
                    width: screenSize.getWidthPerSize(50),
                    child: ElevatedButton(
                      onPressed: () => _viewModel.checkEmail(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorSUB,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        '이메일 주소 인증 완료',
                        style:
                            TextStyle(fontSize: screenSize.getHeightPerSize(2), color: colorMAIN),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.getHeightPerSize(5),
                    child: Image.asset('assets/image/ui/bolt2_dark.png'),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(5),
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
                      fontSize: screenSize.getHeightPerSize(1.3),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _viewModel.reSendEmail(),
                    child: Text(
                      '재전송',
                      style: TextStyle(
                        fontSize: screenSize.getHeightPerSize(1.3),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
