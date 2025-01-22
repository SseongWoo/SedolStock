import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/viewmodel/sign/signin_view_model.dart';
import '../../../constants/color_constants.dart';
import '../../../utils/screen_size.dart';

// 로그인 화면
class SigninScreen extends StatelessWidget {
  final SigninViewModel _viewModel = Get.put(SigninViewModel());
  SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      backgroundColor: colorMAIN,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenSize.getHeightPerSize(18),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(20),
              width: screenSize.getWidthPerSize(80),
              child: Image.asset('assets/image/title.png'),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(2),
            ),
            Container(
              height: screenSize.getHeightPerSize(38),
              width: screenSize.getWidthPerSize(94),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image/ui/login.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    screenSize.getWidthPerSize(8), 0, screenSize.getWidthPerSize(8), 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenSize.getHeightPerSize(2),
                    ),
                    _signinTextField(
                      _viewModel.controllerEmail,
                      '아이디',
                      TextInputType.emailAddress,
                      false,
                      screenSize,
                    ),
                    SizedBox(
                      height: screenSize.getHeightPerSize(2),
                    ),
                    _signinTextField(
                      _viewModel.controllerPassword,
                      '비밀번호',
                      TextInputType.text,
                      true,
                      screenSize,
                    ),
                    SizedBox(
                      height: screenSize.getHeightPerSize(4),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenSize.getHeightPerSize(3.5),
                          child: Image.asset('assets/image/ui/bolt1.png'),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: screenSize.getHeightPerSize(4.5),
                          width: screenSize.getWidthPerSize(55),
                          child: ElevatedButton(
                            onPressed: () async => await _viewModel.signin(),
                            style: ElevatedButton.styleFrom(backgroundColor: colorIfari),
                            child: Text(
                              '로그인',
                              style: TextStyle(
                                color: colorSUB,
                                fontSize: screenSize.getHeightPerSize(3),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: screenSize.getHeightPerSize(3.5),
                          child: Image.asset('assets/image/ui/bolt2.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.getHeightPerSize(2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: screenSize.getHeightPerSize(4),
                          child: _signinButton(
                            _viewModel.goFindPW,
                            '비밀번호 찾기',
                            screenSize,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.getHeightPerSize(4),
                          child: _signinButton(
                            _viewModel.goSignup,
                            '회원가입',
                            screenSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: screenSize.getWidthPerSize(6),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'ver.${_viewModel.publicDataController.appVersion}+${_viewModel.publicDataController.appBuild}',
                  style: TextStyle(fontSize: screenSize.getHeightPerSize(2), fontFamily: 'Dot'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signinTextField(TextEditingController controller, String labelText,
      TextInputType keyboardType, bool obscureText, ScreenSize screenSize) {
    return TextField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white, fontSize: screenSize.getHeightPerSize(2)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorIfari, width: 2.0),
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      obscureText: obscureText,
      cursorColor: Colors.white,
      onTapOutside: (event) => Get.focusScope?.unfocus(),
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
    );
  }

  Widget _signinButton(Function onPressed, String title, ScreenSize screenSize) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Text(
        title,
        style: TextStyle(
          color: colorIfari,
          fontSize: screenSize.getHeightPerSize(1.4),
        ),
      ),
    );
  }
}
