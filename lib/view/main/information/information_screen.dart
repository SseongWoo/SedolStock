import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/color_constants.dart';
import '../../../data/public_data.dart';
import '../../../model/main/information_model.dart';
import '../../../utils/color.dart';
import '../../../utils/format.dart';
import '../../../utils/screen_size.dart';
import '../../../viewmodel/main/information/information_view_model.dart';
import 'information_widget.dart';

// 정보 화면
class InformationScreen extends StatelessWidget {
  final InformationViewModel _viewModel = Get.put(InformationViewModel());
  InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    height: screenSize.getHeightPerSize(12),
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
                            Text(
                              _viewModel.myDataController.myName.value,
                              style: TextStyle(
                                fontSize: screenSize.getHeightPerSize(2),
                              ),
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
                              fontSize: screenSize.getHeightPerSize(1.4),
                            ),
                          ),
                          Obx(
                            () => Text(
                              _viewModel.myRank(),
                              style: TextStyle(
                                fontSize: screenSize.getHeightPerSize(2),
                              ),
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
