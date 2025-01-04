import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/view/sign/signup/signup_widget.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';
import '../../../viewmodel/sign/signup_view_model.dart';

class SignupScreen extends StatelessWidget {
  final SignupViewModel _viewModel = Get.put(SignupViewModel());
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.screenController.updateScreenSize(context);
    });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      backgroundColor: colorMAIN,
      appBar: AppBar(
        backgroundColor: colorMAIN,
        title: const Text('회원가입'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _viewModel.formKey,
          child: Padding(
            padding: EdgeInsets.all(
              screenSize.getWidthPerSize(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _signupTextFieldWidget(
                  _viewModel.controllerID,
                  _viewModel.idLabel,
                  _viewModel.validateId,
                  20,
                ),
                SizedBox(height: screenSize.getHeightPerSize(1)),
                _signupTextFieldWidget(
                  _viewModel.controllerPassword,
                  '비밀번호',
                  _viewModel.validatePassword,
                  20,
                ),
                SizedBox(height: screenSize.getHeightPerSize(1)),
                _signupTextFieldWidget(
                  _viewModel.controllerPasswordCheck,
                  '비밀번호 확인',
                  _viewModel.validatePasswordCheck,
                  20,
                ),
                SizedBox(height: screenSize.getHeightPerSize(1)),
                _signupTextFieldWidget(
                  _viewModel.controllerName,
                  '이름',
                  _viewModel.validateName,
                  12,
                ),
                SizedBox(height: screenSize.getHeightPerSize(1)),
                Obx(
                  () => SignupChoiceFandomWidget(
                    screenSize: screenSize,
                    labelText: _viewModel.labelText.value,
                    labelColor: _viewModel.labelColor,
                    onPressedLeft: _viewModel.onPressedLeft,
                    onPressedRight: _viewModel.onPressedRight,
                  ),
                ),
                SizedBox(
                  width: screenSize.getWidthSize(),
                  child: ElevatedButton(
                    onPressed: () => _viewModel.signup(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorSUB,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      '회원가입',
                      style:
                          TextStyle(fontSize: screenSize.getHeightPerSize(2), color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 텍스트필드 위젯
  Widget _signupTextFieldWidget(TextEditingController textEditingController, String labelText,
      String? Function(String?)? validator, int maxLength) {
    return TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
        textInputAction: TextInputAction.next,
        maxLines: 1,
        maxLength: maxLength,
        onTapOutside: (event) => Get.focusScope?.unfocus(),
        validator: validator);
  }
}
