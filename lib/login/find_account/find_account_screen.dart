import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/find_account/find_account_widget.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';

class FindAccountScreen extends StatelessWidget {
  FindAccountScreen({super.key});
  final ScreenController _screenController = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 찾기'),
        backgroundColor: colorISEGYEIDOL,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(_screenController.screenSize.value.getWidthPerSize(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FindAccountEmailWidget(),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(2),
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
                          fontSize: _screenController.screenSize.value.getHeightPerSize(1.2)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(2),
              ),
              FindAccountButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
