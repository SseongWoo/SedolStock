import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:korean_profanity_filter/korean_profanity_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/login/signup/4_setdata/signup_setdata_system.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';

final ScreenController _screenController = Get.put(ScreenController());

class SignUpSetDataBackButtonWidget extends StatelessWidget {
  const SignUpSetDataBackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SingUpSetDataControll _singUpSetDataControll = Get.find<SingUpSetDataControll>();
    return IconButton(
      onPressed: () {
        _singUpSetDataControll.cancelSignUp();
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }
}

class SignUpSetDataTextWidget extends StatefulWidget {
  const SignUpSetDataTextWidget({super.key});

  @override
  State<SignUpSetDataTextWidget> createState() => _SignUpSetDataTextWidgetState();
}

class _SignUpSetDataTextWidgetState extends State<SignUpSetDataTextWidget> {
  @override
  Widget build(BuildContext context) {
    final SingUpSetDataControll _singUpSetDataControll = Get.find<SingUpSetDataControll>();
    return Form(
      key: _singUpSetDataControll.formKey,
      child: TextFormField(
        controller: _singUpSetDataControll.controllerName,
        decoration: const InputDecoration(labelText: '이름'),
        maxLines: 1,
        maxLength: 12,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        validator: (value) {
          if (value!.isEmpty) {
            return '이름을 입력해주세요';
          }
          if (value.containsBadWords || _singUpSetDataControll.filter.hasProfanity(value)) {
            print(value);
            return '부적절한 언어 사용은 허용되지 않습니다. 다시 입력해 주세요.';
          }
          if (_singUpSetDataControll.overlapName) {
            return '이미 사용 중인 이름입니다. 다른 이름을 선택해 주세요.';
          }

          return null;
        },
      ),
    );
  }
}

class SignUpSetDataButtonWidget extends StatelessWidget {
  const SignUpSetDataButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SingUpSetDataControll _singUpSetDataControll = Get.find<SingUpSetDataControll>();
    return SizedBox(
      width: double.infinity, // 기기의 전체 너비
      child: ElevatedButton(
        onPressed: () async {
          EasyLoading.show(status: '이름 중복 체크 중');
          await _singUpSetDataControll.searchName(_singUpSetDataControll.controllerName.text);
          EasyLoading.dismiss();
          if (_singUpSetDataControll.formKey.currentState!.validate()) {
            _singUpSetDataControll.trySetUserData();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorStelLiveLight, // 버튼 배경색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // 버튼을 둥글게 만들어 FAB 느낌을 줌
          ),
          padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이를 조절
        ),
        child: Text(
          '회원가입 완료',
          style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
        ),
      ),
    );
  }
}

class SignUpDropDownWidget extends StatelessWidget {
  const SignUpDropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SingUpSetDataControll _singUpSetDataControll = Get.find<SingUpSetDataControll>();
    return Center(
      child: Obx(
        () => DropdownButton<String>(
          value: _singUpSetDataControll.selectedName.value,
          alignment: Alignment.center,
          onChanged: (String? newValue) {
            _singUpSetDataControll.updateSelectedName(newValue!);
          },
          items: List.generate(_singUpSetDataControll.nameData.length, (index) {
            return DropdownMenuItem<String>(
              value: _singUpSetDataControll.nameData[index],
              child: Row(
                children: [
                  Icon(
                    _singUpSetDataControll.iconData[index],
                    size: _screenController.screenSize.value.getHeightPerSize(3.5),
                    color: colorList[index],
                  ),
                  SizedBox(width: _screenController.screenSize.value.getWidthPerSize(1.5)),
                  Text(
                    _singUpSetDataControll.nameData[index],
                    style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                        color: colorList[index]),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
