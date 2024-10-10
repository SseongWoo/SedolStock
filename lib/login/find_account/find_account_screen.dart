import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/find_account/find_account_system.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';

class FindAccountScreen extends StatefulWidget {
  const FindAccountScreen({super.key});

  @override
  State<FindAccountScreen> createState() => _FindAccountScreenState();
}

class _FindAccountScreenState extends State<FindAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final ScreenController _screenController = Get.put(ScreenController());
  final FindAccountController _findAccountController = Get.put(FindAccountController());
  final TextEditingController _controllerName = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 찾기'),
        backgroundColor: colorStelLive,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(_screenController.screenSize.value.getWidthPerSize(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controllerName,
                  decoration: const InputDecoration(labelText: '이메일', border: OutlineInputBorder()),
                  maxLines: 1,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '이메일을 입력해 주세요';
                    }

                    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
                      return '유효한 이메일 형식이 아닙니다';
                    }
                    return null;
                  },
                ),
              ),
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
              SizedBox(
                width: double.infinity, // 기기의 전체 너비
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorStelLiveLight, // 버튼 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // 버튼을 둥글게 만들어 FAB 느낌을 줌
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이를 조절
                  ),
                  child: Text(
                    '비밀번호 찾기',
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
