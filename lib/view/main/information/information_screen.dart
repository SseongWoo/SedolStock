import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/public_data.dart';
import '../../../model/main/information_model.dart';
import '../../../utils/color.dart';
import '../../../utils/format.dart';
import '../../../utils/level.dart';
import '../../../utils/screen_size.dart';
import '../../../viewmodel/main/information/information_view_model.dart';
import '../../../widget/divider.dart';
import 'information_widget.dart';

// 정보 화면
class InformationScreen extends StatelessWidget {
  final InformationViewModel _viewModel = Get.put(InformationViewModel());
  InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.screenController.updateScreenSize(context);
    });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    RxString choiceChannel = _viewModel.myDataController.myChoicechannel;
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Obx(
                    () => Container(
                      height: screenSize.getHeightPerSize(8),
                      decoration: BoxDecoration(color: fanColorMap[choiceChannel.value]),
                    ),
                  ),
                  Container(
                    height: screenSize.getHeightPerSize(14),
                    width: screenSize.getWidthSize(),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: screenSize.getHeightPerSize(1),
                      ),
                      child: Obx(
                        () => Column(
                          children: [
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () => _viewModel.goSetting(),
                                    icon: const Icon(Icons.settings))),
                            const Spacer(),
                            Text(
                              choiceChannel.value,
                              style: TextStyle(
                                  fontSize: screenSize.getHeightPerSize(1.6),
                                  color: fanColorMap[choiceChannel.value]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: screenSize.getWidthPerSize(12),
                                ),
                                Text(
                                  _viewModel.myDataController.myName.value,
                                  style: TextStyle(
                                    fontSize: screenSize.getHeightPerSize(2),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.getWidthPerSize(12),
                                  child: getLevelImage(_viewModel.myDataController.myLevel.value) !=
                                          0
                                      ? Image.asset(
                                          'assets/image/level/star${getLevelImage(_viewModel.myDataController.myLevel.value)}.png')
                                      : null,
                                ),
                              ],
                            ),
                          ],
                        ),
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
                      height: screenSize.getHeightPerSize(2),
                    ),
                    GestureDetector(
                      onTap: () => _viewModel.changeFandomDialog(),
                      child: Container(
                        height: screenSize.getHeightPerSize(10),
                        width: screenSize.getHeightPerSize(10),
                        decoration:
                            const BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
                        child: ClipOval(
                          child: Obx(
                            () => Image.asset(
                                'assets/image/fan/${fanImageMap[choiceChannel.value]}.png',
                                errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/image/image_error.png');
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(2),
          ),
          Container(
            height: screenSize.getHeightPerSize(8),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenSize.getHeightPerSize(0.5),
                bottom: screenSize.getHeightPerSize(0.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '전일 대비 자산 변동률',
                          style: TextStyle(
                            fontSize: screenSize.getHeightPerSize(1.4),
                          ),
                        ),
                        Obx(
                          () {
                            RateConfigClass rateConfig = _viewModel.profitRate();
                            return Text(
                              '${rateConfig.rate.toStringAsFixed(2)}%',
                              style: TextStyle(
                                fontSize: screenSize.getHeightPerSize(2),
                                color: rateConfig.rateColor,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  settingVerticalDivider(screenSize),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '전체랭킹',
                          style: TextStyle(
                            fontSize: screenSize.getHeightPerSize(1.4),
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${_viewModel.myDataController.myRank.value != 0 ? _viewModel.myDataController.myRank.value : '-'}',
                            style: TextStyle(
                              fontSize: screenSize.getHeightPerSize(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  settingVerticalDivider(screenSize),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '팬덤랭킹',
                          style: TextStyle(
                            fontSize: screenSize.getHeightPerSize(1.4),
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${_viewModel.myDataController.myFandomRank.value != 0 ? _viewModel.myDataController.myFandomRank.value : '-'}',
                            style: TextStyle(
                              fontSize: screenSize.getHeightPerSize(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(2),
          ),
          Container(
            height: screenSize.getHeightPerSize(4),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.getWidthPerSize(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '내 자산',
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(2.2),
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    _viewModel.notBankruptcy.value
                        ? '${formatToCurrency(_viewModel.myDataController.myTotalMoney.value)} P'
                        : '파산',
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(2.2),
                      fontWeight: _viewModel.notBankruptcy.value ? null : FontWeight.bold,
                      color: _viewModel.notBankruptcy.value ? Colors.black : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(2),
          ),
          Container(
            height: screenSize.getHeightPerSize(36),
            width: screenSize.getWidthSize(),
            color: Colors.white,
            child: _viewModel.notBankruptcy.value
                ? MyMoneyChartLine(
                    viewModel: _viewModel,
                  )
                : Image.asset('assets/image/ui/lose.png'),
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(2),
          ),
          _viewModel.myDataController.myMoney < 500000
              ? Center(
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/image/ui/bankruptcyBG.png',
                        width: screenSize.getWidthPerSize(80),
                      ),
                      GestureDetector(
                        onTap: () => _viewModel.tryRestart(),
                        child: Image.asset(
                          'assets/image/ui/bankruptcyBT.png',
                          width: screenSize.getWidthPerSize(80),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          // SizedBox(
          //   width: screenSize.getWidthPerSize(80),
          //   child: ElevatedButton(
          //     onPressed: _viewModel.tryRestart,
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.red,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //     child: Text(
          //       '파산 신청',
          //       style: TextStyle(fontSize: screenSize.getHeightPerSize(2.2), color: Colors.white),
          //     ),
          //   ),
          // ),
          //informationButton('파산 신청', _viewModel.tryRestart, screenSize),
        ],
      ),
    );
  }

  // // 내 자산 부분 텍스트 위젯
  // Widget _propertyTextWidget(ScreenSize screenSize, String title, String value) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyle(
  //           fontSize: screenSize.getHeightPerSize(1.6),
  //           color: colorISEGYEIDOL,
  //         ),
  //       ),
  //       Text(
  //         value,
  //         style: TextStyle(
  //           fontSize: screenSize.getHeightPerSize(1.6),
  //           color: colorISEGYEIDOL,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

class StripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintYellow = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    final paintBlack = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    double stripeWidth = 40; // 사선 스트라이프 간격

    for (double i = -size.height; i < size.width; i += stripeWidth * 2) {
      Path yellowStripe = Path()
        ..moveTo(i, 0)
        ..lineTo(i + stripeWidth, 0)
        ..lineTo(i + stripeWidth + size.height, size.height)
        ..lineTo(i + size.height, size.height)
        ..close();

      Path blackStripe = Path()
        ..moveTo(i + stripeWidth, 0)
        ..lineTo(i + stripeWidth * 2, 0)
        ..lineTo(i + stripeWidth * 2 + size.height, size.height)
        ..lineTo(i + stripeWidth + size.height, size.height)
        ..close();

      canvas.drawPath(yellowStripe, paintYellow);
      canvas.drawPath(blackStripe, paintBlack);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
