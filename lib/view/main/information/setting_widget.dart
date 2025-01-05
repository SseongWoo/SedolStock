import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/viewmodel/main/information/setting_app_view_model.dart';
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
            firstChild: SizedBox(
              width: screenSize.getWidthSize(),
            ),
            secondChild: Padding(
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
            crossFadeState: viewModel.audioController.onAudio.value
                ? CrossFadeState.showSecond // 확장된 상태
                : CrossFadeState.showFirst, // 숨겨진 상태
          ),
        ),
      ],
    );
  }
}

// 파산 신청 다이얼로그
class RestartDialog extends StatelessWidget {
  final ScreenSize screenSize;
  final Function onPressed;
  const RestartDialog({super.key, required this.screenSize, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('파산 신청'),
      content: Text(
        '파산 신청을 진행하시겠습니까?\n파산을 신청하면 모든 데이터가 초기화되며, 자동으로 로그아웃됩니다. 이 작업은 되돌릴 수 없으니 신중하게 결정해 주세요.',
        style: TextStyle(
          fontSize: screenSize.getHeightPerSize(1.8),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            onPressed();
          },
          child: const Text('파산'),
        ),
      ],
    );
  }
}
