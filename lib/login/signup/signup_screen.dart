import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/signup_system.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final ScreenController _screenController = Get.put(ScreenController());
  final TextEditingController _controllerID = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPasswordCheck = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerID.dispose();
    _controllerPassword.dispose();
    _controllerPasswordCheck.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorStelLive,
        title: const Text('회원가입'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_screenController.screenSize.value.getWidthPerSize(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: _screenController.screenSize.value.getHeightPerSize(4),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '*필수',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _controllerID,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: '아이디'),
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  maxLength: 20,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '아이디를 입력해 주세요';
                    }
                    if (value.length < 5) {
                      return '아이디를 다섯글자 이상 입력해 주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: _screenController.screenSize.value.getHeightPerSize(4),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '*필수',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _controllerPassword,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder(), labelText: '비밀번호'),
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  maxLength: 20,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '비밀번호를 입력해 주세요';
                    }
                    if (value.length < 6) {
                      return '비밀번호를 여섯글자 이상 입력해 주세요';
                    }
                    if (value == _controllerPasswordCheck.text) {
                      return '비밀번호가 동일하지 않습니다.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: _screenController.screenSize.value.getHeightPerSize(4),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '*필수',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _controllerPasswordCheck,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder(), labelText: '비밀번호 확인'),
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  maxLength: 20,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value == _controllerPassword.text) {
                      return '비밀번호가 동일하지 않습니다.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: _screenController.screenSize.value.getHeightPerSize(4),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '*선택',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _controllerEmail,
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: '이메일'),
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  maxLength: 20,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value!.isNotEmpty &&
                        !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                            .hasMatch(value)) {
                      return '이메일이 올바르지 않습니다.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: _screenController.screenSize.value.getHeightPerSize(2),
                ),
                Text(
                  '이메일 입력은 선택 사항입니다.\n이메일을 등록하시면 비밀번호 찾기와 변경을 할 수 있습니다.',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.5)),
                ),
                SizedBox(
                  height: _screenController.screenSize.value.getHeightPerSize(2),
                ),
                SizedBox(
                  width: double.infinity, // 기기의 전체 너비
                  child: ElevatedButton(
                    onPressed: () {
                      goSignUpCheckEmail('csw10211@naver.com');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorStelLiveLight, // 버튼 배경색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // 버튼을 둥글게 만들어 FAB 느낌을 줌
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이를 조절
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(fontSize: 18),
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
}
