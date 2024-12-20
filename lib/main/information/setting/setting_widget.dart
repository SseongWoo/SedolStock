import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/utils/audio.dart';
import 'package:stockpj/utils/color.dart';
import '../../../utils/screen_size.dart';
import '../information_system.dart';

// 관리 화면 버튼 위젯
class SettingButtonWidget extends StatelessWidget {
  final String title;
  final Function function;
  const SettingButtonWidget({super.key, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          function();
        },
      ),
    );
  }
}

// 파산 신청 다이얼로그
class ReStartDialog extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final InformationController _informationController = Get.find<InformationController>();
  ReStartDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('파산 신청'),
      content: Text(
        '파산 신청을 진행하시겠습니까?\n파산을 신청하면 모든 데이터가 초기화되며, 자동으로 로그아웃됩니다. 이 작업은 되돌릴 수 없으니 신중하게 결정해 주세요.',
        style: TextStyle(
          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
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
          onPressed: () async {
            Get.back();
            await _informationController.restartUserData();
          },
          child: const Text('파산'),
        ),
      ],
    );
  }
}

// 버튼 사이 구분선 위젯
Widget settingDivider() {
  final ScreenController screenController = Get.find<ScreenController>();
  return Divider(
    indent: screenController.screenSize.value.getWidthPerSize(4),
    endIndent: screenController.screenSize.value.getWidthPerSize(4),
    color: Colors.grey,
    thickness: 0.5,
    height: 0,
  );
}

class SettingAudioWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final AudioController _audioController = Get.find<AudioController>();
  SettingAudioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: _screenController.screenSize.value.getHeightPerSize(8),
          width: _screenController.screenSize.value.getWidthSize(),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              left: _screenController.screenSize.value.getWidthPerSize(3),
              right: _screenController.screenSize.value.getWidthPerSize(3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '효과음',
                      style: TextStyle(
                          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8)),
                    ),
                    Obx(
                      () => Text(
                        _audioController.onAudio.value ? '사용함' : '사용안함',
                        style: TextStyle(
                            fontSize: _screenController.screenSize.value.getHeightPerSize(1.2),
                            color: _audioController.onAudio.value ? colorSUB : Colors.grey),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Switch(
                    value: _audioController.onAudio.value,
                    onChanged: (value) {
                      _audioController.onoffAudio();
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
              width: _screenController.screenSize.value.getWidthSize(),
            ),
            secondChild: Padding(
              padding: EdgeInsets.only(
                left: _screenController.screenSize.value.getWidthPerSize(3),
                right: _screenController.screenSize.value.getWidthPerSize(3),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _audioController.audioVolume.value,
                      onChanged: (value) {
                        _audioController.audioVolume.value = value;
                        _audioController.audioPlayer.setVolume(value);
                      },
                      activeColor: colorSUB,
                      inactiveColor: colorMAIN,
                      thumbColor: fanColorMap[_myDataController.myChoicechannel.value],
                      divisions: 10,
                      label: '${(_audioController.audioVolume.value * 100).toInt()}%',
                      min: 0.0,
                      max: 1.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _audioController.playSound('assets/sound/testsound.wav');
                    },
                    icon: const Icon(Icons.volume_up),
                  ),
                ],
              ),
            ),
            crossFadeState: _audioController.onAudio.value
                ? CrossFadeState.showSecond // 확장된 상태
                : CrossFadeState.showFirst, // 숨겨진 상태
          ),
        ),
      ],
    );
  }
}
