import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/view/sign/signup/signup_checkemail_widget.dart';
import '../../../utils/color.dart';
import '../../../viewmodel/sign/signup_checkemail_view_model.dart';

class SignupCheckemailScreen extends StatelessWidget {
  final SignupCheckemailViewModel _viewModel = Get.put(SignupCheckemailViewModel());
  SignupCheckemailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.screenController.updateScreenSize(context);
    });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorISEGYEIDOL,
        leading: IconButton(
          onPressed: _viewModel.cancelSignUp,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('회원가입'),
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
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(3),
              ),
              Text(
                '${_viewModel.id}님,\n\n인증 이메일을 발송했습니다. 메일을 확인하시고 링크를 클릭하여 인증을 완료해 주세요. 감사합니다.',
                style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(1.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(5),
              ),
              SizedBox(
                width: screenSize.getWidthPerSize(50),
                child: ElevatedButton(
                  onPressed: () => _viewModel.checkEmail(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorISEGYEIDOLLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    '이메일 주소 인증 완료',
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(2),
                    ),
                  ),
                ),
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
