import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/signup_system.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';

class SignupSetprofileScreen extends StatefulWidget {
  const SignupSetprofileScreen({super.key});

  @override
  State<SignupSetprofileScreen> createState() => _SignupSetprofileScreenState();
}

class _SignupSetprofileScreenState extends State<SignupSetprofileScreen> {
  final ScreenController _screenController = Get.put(ScreenController());
  final TextEditingController _controllerName = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    _screenController.updateScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        backgroundColor: colorStelLive,
        leading: IconButton(
          onPressed: () {
            cancelSignUp();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getWidthPerSize(5)),
        child: Center(
          child: Column(
            children: [
              Container(
                height: _screenController.screenSize.value.getWidthPerSize(50),
                width: _screenController.screenSize.value.getWidthPerSize(50),
                color: Colors.green,
                child: Text('이미지'),
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(4),
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controllerName,
                  decoration: const InputDecoration(labelText: '닉네임'),
                  maxLines: 1,
                  maxLength: 12,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(8),
              ),
              SizedBox(
                width: double.infinity, // 기기의 전체 너비
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorStelLiveLight, // 버튼 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // 버튼을 둥글게 만들어 FAB 느낌을 줌
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이를 조절
                  ),
                  child: Text(
                    '회원가입 완료',
                    style:
                        TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
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
