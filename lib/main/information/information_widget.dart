import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color.dart';
import '../../utils/screen_size.dart';

final ScreenController _screenController = Get.put(ScreenController());

class InformationMyWidget extends StatelessWidget {
  const InformationMyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(8),
              decoration: BoxDecoration(color: colorAkaneLize),
            ),
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(12),
              color: Colors.white,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: _screenController.screenSize.value.getHeightPerSize(2)),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '소속,',
                        style: TextStyle(
                            fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
                      ),
                      Text(
                        '닉네임',
                        style: TextStyle(
                            fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(8),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  top: _screenController.screenSize.value.getHeightPerSize(0.5),
                  bottom: _screenController.screenSize.value.getHeightPerSize(0.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 0.25),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '총 수익률',
                              style: TextStyle(
                                fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                              ),
                            ),
                            Text(
                              '+85%',
                              style: TextStyle(
                                fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.grey, width: 0.25),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '랭킹',
                              style: TextStyle(
                                fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                              ),
                            ),
                            Text(
                              '순위 밖',
                              style: TextStyle(
                                fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(2),
              ),
              Container(
                height: _screenController.screenSize.value.getHeightPerSize(12),
                width: _screenController.screenSize.value.getHeightPerSize(12),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InformationPropertyWidget extends StatelessWidget {
  const InformationPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            _screenController.screenSize.value.getWidthPerSize(10),
            _screenController.screenSize.value.getHeightPerSize(1),
            _screenController.screenSize.value.getWidthPerSize(10),
            _screenController.screenSize.value.getHeightPerSize(1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '내 자산',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(1),
            ),
            const PropertyRowWidget(
              title: '총 자산',
              value: '100,000,000,000',
            ),
            const PropertyRowWidget(
              title: '가용 자산',
              value: '100,000,000,000',
            ),
            const PropertyRowWidget(
              title: '보유 주식 자산',
              value: '100,000,000,000',
            ),
            const PropertyRowWidget(
              title: '보유 주식 종목 개수',
              value: '12 종목',
            ),
            const PropertyRowWidget(
              title: '보유 주식 개수',
              value: '200 주',
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyRowWidget extends StatelessWidget {
  final String title;
  final String value;
  const PropertyRowWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
            color: colorStelLiveDark,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
            color: colorStelLiveDark,
          ),
        ),
      ],
    );
  }
}

class InformationButtonWidget extends StatelessWidget {
  final String title;
  final Function function;
  const InformationButtonWidget({super.key, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          function();
        },
      ),
    );
  }
}

Widget settingTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(left: _screenController.screenSize.value.getWidthPerSize(2)),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
        ),
      ),
    ),
  );
}

Widget settingDivider() {
  return Divider(
    indent: _screenController.screenSize.value.getWidthPerSize(4),
    endIndent: _screenController.screenSize.value.getWidthPerSize(4),
    color: Colors.grey, // 경계선 색상
    thickness: 0.5, // 경계선 두께
    height: 0, // 경계선 위아래 여백
  );
}
