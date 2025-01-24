import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/viewmodel/main/information/setting_app_view_model.dart';
import 'package:stockpj/widget/button.dart';
import '../../../constants/color_constants.dart';
import '../../../utils/color.dart';
import '../../../utils/screen_size.dart';

class AudioSettingWidget extends StatelessWidget {
  final SettingAppViewModel viewModel;
  const AudioSettingWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    return Column(
      children: [
        Container(
          height: screenSize.getHeightPerSize(8),
          width: screenSize.getWidthSize(),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              left: screenSize.getWidthPerSize(3),
              right: screenSize.getWidthPerSize(3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '효과음',
                      style: TextStyle(fontSize: screenSize.getHeightPerSize(1.8)),
                    ),
                    Obx(
                      () => Text(
                        viewModel.audioController.onAudio.value ? '사용함' : '사용안함',
                        style: TextStyle(
                            fontSize: screenSize.getHeightPerSize(1.2),
                            color:
                                viewModel.audioController.onAudio.value ? colorSUB : Colors.grey),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Switch(
                    value: viewModel.audioController.onAudio.value,
                    onChanged: (value) {
                      viewModel.audioController.onoffAudio();
                    },
                    activeColor: colorMAIN,
                    activeTrackColor: colorSUB,
                    inactiveThumbColor: colorSUB,
                    inactiveTrackColor: colorMAIN,
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: Container(
              width: screenSize.getWidthSize(),
              color: Colors.white,
            ),
            secondChild: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenSize.getWidthPerSize(3),
                  right: screenSize.getWidthPerSize(3),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: viewModel.audioController.audioVolume.value,
                        onChanged: (value) {
                          viewModel.audioController.audioVolume.value = value;
                          viewModel.audioController.audioPlayer.setVolume(value);
                        },
                        activeColor: colorSUB,
                        inactiveColor: colorMAIN,
                        thumbColor: fanColorMap[viewModel.myDataController.myChoicechannel.value],
                        divisions: 10,
                        label: '${(viewModel.audioController.audioVolume.value * 100).toInt()}%',
                        min: 0.0,
                        max: 1.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        viewModel.audioController.playSound('assets/sound/testsound.wav');
                      },
                      icon: const Icon(Icons.volume_up),
                    ),
                  ],
                ),
              ),
            ),
            crossFadeState: viewModel.audioController.onAudio.value
                ? CrossFadeState.showSecond // 확장된 상태
                : CrossFadeState.showFirst, // 숨겨진 상태
          ),
        ),
      ],
    );
  }
}

class LogoutDialog extends StatelessWidget {
  final SettingAppViewModel viewModel;

  const LogoutDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;

    return AlertDialog(
      title: const Text('로그아웃'),
      content: Text(
        '로그아웃하시겠습니까?',
        style: TextStyle(fontSize: screenSize.getHeightPerSize(1.8)),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: viewModel.logout,
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}

// 이름 변경 다이얼로그
class NameChangeDialog extends StatelessWidget {
  final SettingAppViewModel viewModel;
  const NameChangeDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = viewModel.screenController.screenSize.value;
    return Center(
      child: Container(
        height: screenSize.getHeightPerSize(24),
        width: screenSize.getWidthPerSize(70),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenSize.getHeightPerSize(2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '이름 변경',
                style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(1.8),
                ),
              ),
              Form(
                key: viewModel.formKey,
                child: TextFormField(
                  controller: viewModel.controllerName,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(
                      viewModel.screenController.screenSize.value.getHeightPerSize(0.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  maxLines: 1,
                  maxLength: 12,
                  onTapOutside: (event) => FocusScope.of(Get.context!).unfocus(),
                  validator: viewModel.validateName,
                ),
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: dialogButton(screenSize, '취소', Colors.white, Get.back)),
                    SizedBox(
                      width: screenSize.getHeightPerSize(2),
                    ),
                    Expanded(
                        child: dialogButton(screenSize, '변경', colorMAIN, () {
                      viewModel.nameChange();
                    })),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 비밀번호 변경 다이얼로그
class ChangePasswordDialog extends StatelessWidget {
  final String email;
  final ScreenSize screenSize;

  const ChangePasswordDialog({
    super.key,
    required this.email,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('비밀번호 변경'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '비밀번호 변경 안내 이메일이 아래 주소로 발송되었습니다.',
            style: TextStyle(fontSize: screenSize.getHeightPerSize(1.8)),
          ),
          SizedBox(height: screenSize.getHeightPerSize(1)),
          Text(
            email,
            style: TextStyle(fontSize: screenSize.getHeightPerSize(2)),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('확인'),
        ),
      ],
    );
  }
}

class WindowsSizeDialog extends StatelessWidget {
  final ScreenController screenController;
  final List<int> sizeList;

  const WindowsSizeDialog({
    super.key,
    required this.screenController,
    required this.sizeList,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: screenController.screenSize.value.getWidthPerSize(80),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: sizeList.map((size) {
              return RadioListTile(
                value: size.toString(),
                groupValue: screenController.sizePer.toString(),
                title: Text('$size%'),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    int selectedPercent = int.parse(newValue);
                    screenController.setWindowsSize(selectedPercent);
                  }
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
