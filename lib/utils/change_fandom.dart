import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/constants/color_constants.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/widget/button.dart';
import '../constants/data_constants.dart';
import '../data/public_data.dart';
import '../main.dart';
import '../service/http_service.dart';
import '../widget/simple_widget.dart';
import 'color.dart';

// 팬덤 업데이트 기능
Future<bool> _updateFandom(String myUid, String originalFandom, String newFandom) async {
  final HttpService httpService = HttpService();
  try {
    final response = await httpService.putRequest('/fanname/update', {
      'uid': myUid,
      'originalFandom': originalFandom,
      'newFandom': newFandom,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('error ${response.statusCode}');
    }
  } catch (e) {
    logger.e('updateFandom error : $e');
    return false;
  }
}

// 팬덤 번경 기능
void changeFandom(int index, MyDataController myDataController) async {
  EasyLoading.show(status: '등록중');
  if (fanNameList[index] != myDataController.myChoicechannel.value) {
    bool checkFandom = await _updateFandom(
        myDataController.myUid.value, myDataController.myChoicechannel.value, fanNameList[index]);
    EasyLoading.dismiss();
    if (checkFandom) {
      myDataController.myChoicechannel.value = fanNameList[index];
      showSimpleSnackbar('변경 완료', '팬네임 변경이 완료되었습니다', SnackPosition.TOP, Colors.black);
    } else {
      showSimpleSnackbar('변경 실패', '팬네임 변경에 실패하였습니다\n다시 시도해 주세요', SnackPosition.TOP, Colors.black);
    }
  } else {
    EasyLoading.dismiss();
  }
}

class FandomChangeDialog extends StatelessWidget {
  final ScreenSize screenSize;
  final MyDataController myDataController;

  const FandomChangeDialog({
    super.key,
    required this.screenSize,
    required this.myDataController,
  });

  @override
  Widget build(BuildContext context) {
    RxInt dialogIndex = fanNameList.indexOf(myDataController.myChoicechannel.value).obs;
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (value) {
        // 키보드 이벤트
        if (value is KeyDownEvent) {
          if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
            if (dialogIndex.value <= 0) {
              dialogIndex.value = fanNameList.length - 1;
            } else {
              dialogIndex.value--;
            }
          }
          if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
            if (dialogIndex.value >= fanNameList.length - 1) {
              dialogIndex.value = 0;
            } else {
              dialogIndex.value++;
            }
          }

          if (value.logicalKey == LogicalKeyboardKey.enter) {
            Get.back();
            changeFandom(dialogIndex.value, myDataController);
          }
        }
      },
      child: Center(
        child: Container(
          height: screenSize.getHeightPerSize(30),
          width: screenSize.getWidthPerSize(70),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenSize.getHeightPerSize(2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '팬덤 변경',
                  style: TextStyle(
                    fontSize: screenSize.getHeightPerSize(1.8),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (dialogIndex.value <= 0) {
                          dialogIndex.value = fanNameList.length - 1;
                        } else {
                          dialogIndex.value--;
                        }
                      },
                      icon: Icon(
                        Icons.arrow_left,
                        size: screenSize.getHeightPerSize(5),
                      ),
                    ),
                    Obx(
                      () => Column(
                        children: [
                          Container(
                            height: screenSize.getHeightPerSize(10),
                            width: screenSize.getHeightPerSize(10),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blueAccent),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/image/fan/${fanImageMap[fanNameList[dialogIndex.value]]}.png',
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset('assets/image/image_error.png');
                                },
                              ),
                            ),
                          ),
                          Text(
                            fanNameList[dialogIndex.value],
                            style: TextStyle(
                              color: fanColorMap[fanNameList[dialogIndex.value]],
                              fontSize: screenSize.getHeightPerSize(3),
                              shadows: const [
                                Shadow(offset: Offset(-1.5, -1.5), color: Colors.black), // 좌상단
                                Shadow(offset: Offset(1.5, -1.5), color: Colors.black), // 우상단
                                Shadow(offset: Offset(1.5, 1.5), color: Colors.black), // 우하단
                                Shadow(offset: Offset(-1.5, 1.5), color: Colors.black), // 좌하단
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (dialogIndex.value >= fanNameList.length - 1) {
                          dialogIndex.value = 0;
                        } else {
                          dialogIndex.value++;
                        }
                      },
                      icon: Icon(
                        Icons.arrow_right,
                        size: screenSize.getHeightPerSize(5),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
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
                        child: dialogButton(
                          screenSize,
                          '변경',
                          colorMAIN,
                          () => {Get.back(), changeFandom(dialogIndex.value, myDataController)},
                        ),
                      ),
                    ],
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
