import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/viewmodel/sign/find_account_view_model.dart';
import '../../../constants/color_constants.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';

// 계정 찾기 화면
class FindAccountScreen extends StatelessWidget {
  final FindAccountViewModel _viewModel = Get.put(FindAccountViewModel());
  FindAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.screenController.updateScreenSize(context);
    });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 찾기'),
        backgroundColor: colorMAIN,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: screenSize.getWidthPerSize(10),
            right: screenSize.getWidthPerSize(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _viewModel.formKey,
                child: TextFormField(
                  controller: _viewModel.controllerName,
                  decoration: const InputDecoration(labelText: '이메일', border: OutlineInputBorder()),
                  maxLines: 1,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: _viewModel.validateEmail,
                ),
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(2),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.orange,
                  ),
                  Expanded(
                    child: Text(
                      '이메일 인증을 완료한 사용자만 비밀번호 찾기 서비스를 이용할 수 있습니다.',
                      style: TextStyle(
                        fontSize: screenSize.getHeightPerSize(1.2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(2),
              ),
              SizedBox(
                width: screenSize.getWidthSize(),
                child: ElevatedButton(
                  onPressed: _viewModel.onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorSUB,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    '비밀번호 찾기',
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(2), color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
