import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/color.dart';

import '../../../utils/screen_size.dart';
import '../../../utils/timer.dart';
import 'my_information_setting_system.dart';
import 'my_information_setting_widget.dart';

class MyInformationSettingScreen extends StatefulWidget {
  const MyInformationSettingScreen({super.key});

  @override
  State<MyInformationSettingScreen> createState() => _MyInformationSettingScreenState();
}

class _MyInformationSettingScreenState extends State<MyInformationSettingScreen> {
  final ScreenController _screenController = Get.put(ScreenController());
  final MyInformationSettingController _myInformationSettingController =
      Get.put(MyInformationSettingController());

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Scaffold(
      backgroundColor: Color.lerp(colorIve, Colors.white, 0.6),
      appBar: AppBar(
        title: const Text('내 설정'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: _screenController.screenSize.value.getWidthPerSize(2)),
            child: TimerWidget(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              _screenController.screenSize.value.getWidthPerSize(10),
              _screenController.screenSize.value.getHeightPerSize(3),
              _screenController.screenSize.value.getWidthPerSize(10),
              _screenController.screenSize.value.getHeightPerSize(3)),

          // EdgeInsets.only(
          //     left: _screenController.screenSize.value.getWidthPerSize(15),
          //     right: _screenController.screenSize.value.getWidthPerSize(15)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  _screenController.screenSize.value.getWidthPerSize(5),
                  _screenController.screenSize.value.getHeightPerSize(2),
                  _screenController.screenSize.value.getWidthPerSize(5),
                  _screenController.screenSize.value.getHeightPerSize(2)),
              child: Column(
                children: [
                  SizedBox(
                    height: _screenController.screenSize.value.getHeightPerSize(4),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: _screenController.screenSize.value.getHeightPerSize(15),
                        width: _screenController.screenSize.value.getHeightPerSize(15),
                        decoration:
                            const BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.photo_camera,
                            size: _screenController.screenSize.value.getHeightPerSize(3.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _screenController.screenSize.value.getHeightPerSize(4),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '닉네임',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1.5),
                      ),
                    ),
                  ),
                  SettingMyNameWidget(),
                  SizedBox(
                    height: _screenController.screenSize.value.getHeightPerSize(4),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '소속',
                      style: TextStyle(
                        fontSize: _screenController.screenSize.value.getHeightPerSize(1.5),
                      ),
                    ),
                  ),
                  SettingDropDownWidget(),
                  SizedBox(
                    height: _screenController.screenSize.value.getHeightPerSize(4),
                  ),
                  SizedBox(
                    width: double.infinity, // 기기의 전체 너비
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorStelLiveLight, // 버튼 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // 버튼을 둥글게 만들어 FAB 느낌을 줌
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이를 조절
                      ),
                      child: Text(
                        '변경하기',
                        style: TextStyle(
                            fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
