import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/view/sign/signup/signup_widget.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/data_constants.dart';
import '../../../utils/screen_size.dart';
import '../../../viewmodel/sign/signup_view_model.dart';

class SignupScreen extends StatelessWidget {
  final SignupViewModel _viewModel = Get.put(SignupViewModel());
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _viewModel.screenController.updateScreenSize(context);
    // });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorMAIN,
        title: Text(
          '${_viewModel.idLabel} 회원가입',
          style: TextStyle(fontSize: screenSize.getHeightPerSize(2.6)),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: colorMAIN,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenSize.getHeightPerSize(2),
                    horizontal: screenSize.getWidthPerSize(5),
                  ),
                  child: Column(
                    children: [
                      _signupTextFieldWidget(
                          _viewModel.controllerID,
                          screenSize,
                          '${_viewModel.idLabel} 아이디',
                          _viewModel.validateId,
                          _viewModel.lengthID(),
                          null,
                          false),
                      SizedBox(height: screenSize.getHeightPerSize(1)),
                      Obx(
                        () => _signupTextFieldWidget(
                          _viewModel.controllerPassword,
                          screenSize,
                          '비밀번호',
                          _viewModel.validatePassword,
                          20,
                          _viewModel.changeVisPW,
                          _viewModel.visPW.value,
                        ),
                      ),
                      SizedBox(height: screenSize.getHeightPerSize(1)),
                      Obx(
                        () => _signupTextFieldWidget(
                          _viewModel.controllerPasswordCheck,
                          screenSize,
                          '비밀번호 확인',
                          _viewModel.validatePasswordCheck,
                          20,
                          _viewModel.changeVisPW,
                          _viewModel.visPW.value,
                        ),
                      ),
                      SizedBox(height: screenSize.getHeightPerSize(1)),
                      _signupTextFieldWidget(
                        _viewModel.controllerName,
                        screenSize,
                        '이름',
                        _viewModel.validateName,
                        12,
                        null,
                        false,
                      ),
                      SizedBox(height: screenSize.getHeightPerSize(2)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(12),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: colorMAIN,
                          ),
                        ),
                        Container(
                          height: screenSize.getHeightPerSize(1.5),
                          color: colorSUB,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorSUB,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
                          child: Obx(
                            () => ClipOval(
                              child: Image.asset(
                                  'assets/image/fan/${fanEnNameList[_viewModel.listIndex.value]}.png',
                                  errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/image/image_error.png');
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.getWidthPerSize(5),
                  ),
                  child: Column(
                    children: [
                      Obx(
                        () => SignupChoiceFandomWidget(
                          screenSize: screenSize,
                          labelText: _viewModel.labelText.value,
                          labelColor: _viewModel.labelColor,
                          onPressedLeft: _viewModel.onPressedLeft,
                          onPressedRight: _viewModel.onPressedRight,
                        ),
                      ),
                      SizedBox(height: screenSize.getHeightPerSize(4)),
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
                            style: TextStyle(
                                fontSize: screenSize.getHeightPerSize(2), color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 텍스트필드 위젯
  Widget _signupTextFieldWidget(
      TextEditingController textEditingController,
      ScreenSize screenSize,
      String labelText,
      String? Function(String?)? validator,
      int? maxLength,
      Function? onPressed,
      bool visPW) {
    return SizedBox(
      height: screenSize.getHeightPerSize(8),
      child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: labelText,
              labelStyle: TextStyle(fontSize: screenSize.getHeightPerSize(2)),
              suffixIcon: onPressed != null
                  ? IconButton(
                      onPressed: () {
                        onPressed();
                      },
                      icon: Icon(visPW ? Icons.visibility : Icons.visibility_off))
                  : null),
          obscureText: visPW,
          textInputAction: TextInputAction.next,
          maxLines: 1,
          maxLength: maxLength,
          onTapOutside: (event) => Get.focusScope?.unfocus(),
          validator: validator),
    );
  }
}
