import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../constants/color_constants.dart';
import '../../../utils/color.dart';
import '../../../viewmodel/sign/signup_choice_view_model.dart';

class SignupChoiceScreen extends StatelessWidget {
  final SignupChoiceViewModel _viewModel = Get.put(SignupChoiceViewModel());
  SignupChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.screenController.updateScreenSize(context);
    });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorMAIN,
      ),
      backgroundColor: colorMAIN,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: screenSize.getHeightPerSize(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _choiceButton(
                screenSize,
                '이메일 회원가입',
                '이메일로 가입하시면 계정 찾기와\n비밀번호 재설정이 가능합니다.',
                true,
                () => _viewModel.goSignUp(true),
              ),
              _choiceButton(
                screenSize,
                '게스트 회원가입',
                '이메일 없이 사용 가능하지만\n계정 복구는 불가능합니다.',
                false,
                () => _viewModel.goSignUp(false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _choiceButton(
      ScreenSize screenSize, String title, String value, bool email, Function onTap) {
    return Card(
      color: colorSUB,
      child: InkWell(
        onTap: () => onTap(),
        child: SizedBox(
          height: screenSize.getHeightPerSize(25),
          width: screenSize.getWidthPerSize(44),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenSize.getHeightPerSize(8),
                child: email
                    ? const FittedBox(
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                      )
                    : Image.asset('assets/image/ui/people.png'),
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              Text(
                title,
                style: TextStyle(fontSize: screenSize.getHeightPerSize(2.8), color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenSize.getWidthPerSize(2), right: screenSize.getWidthPerSize(2)),
                child: Text(
                  value,
                  style: TextStyle(fontSize: screenSize.getHeightPerSize(1.3), color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
