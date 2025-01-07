import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/color_constants.dart';
import '../../../utils/format.dart';
import '../../../utils/screen_size.dart';
import '../../../viewmodel/main/information/information_view_model.dart';
import '../../../widget/button.dart';
import '../../../widget/divider.dart';
import 'information_widget.dart';

// 정보 화면
class InformationScreen extends StatelessWidget {
  final InformationViewModel _viewModel = Get.put(InformationViewModel());
  InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return SingleChildScrollView(
      child: Column(
        children: [
          InformationMyDataWidget(
            viewModel: _viewModel,
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(2),
          ),
          Container(
            height: screenSize.getHeightPerSize(36),
            color: Colors.white,
            child: MyMoneyChartLine(
              viewModel: _viewModel,
            ),
          ),
          // Container(
          //   height: screenSize.getHeightPerSize(35),
          //   color: Colors.white,
          //   child: MoneyPieChartWidget(
          //     viewModel: _viewModel,
          //   ),
          // ),
          SizedBox(
            height: screenSize.getHeightPerSize(2),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  screenSize.getWidthPerSize(10),
                  screenSize.getHeightPerSize(1),
                  screenSize.getWidthPerSize(10),
                  screenSize.getHeightPerSize(1)),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '내 자산',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: screenSize.getHeightPerSize(2.5),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.getHeightPerSize(1),
                    ),
                    _propertyTextWidget(
                      screenSize,
                      '총 자산',
                      formatToCurrency(_viewModel.myDataController.myTotalMoney.value),
                    ),
                    _propertyTextWidget(
                      screenSize,
                      '가용 자산',
                      formatToCurrency(_viewModel.myDataController.myMoney.value),
                    ),
                    _propertyTextWidget(
                      screenSize,
                      '보유 주식 자산',
                      formatToCurrency(_viewModel.myDataController.myStockMoney.value),
                    ),
                    _propertyTextWidget(
                      screenSize,
                      '보유 주식 종목 개수',
                      '${_viewModel.myDataController.myStockList.value} 종목',
                    ),
                    _propertyTextWidget(
                      screenSize,
                      '보유 주식 개수',
                      '${_viewModel.myDataController.myStockCount.value} 주',
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(1),
          ),
          _settingTitle(screenSize, '정보 설정'),
          informationButton(
            '내 이름 변경',
            _viewModel.nameChangeDialog,
          ),
          settingDivider(
            screenSize,
          ),
          informationButton(
            '대표 팬덤 변경',
            _viewModel.changeFandomDialog,
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(1),
          ),
          _settingTitle(screenSize, '계정 설정'),
          informationButton(
            '비밀번호 변경',
            _viewModel.sendPasswordResetEmail,
          ),
          settingDivider(
            screenSize,
          ),
          informationButton(
            '로그아웃',
            _viewModel.logoutDialog,
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(1),
          ),
          _settingTitle(screenSize, '데이터 및 계정 관리'),
          informationButton(
            '관리',
            _viewModel.goSetting,
          ),
          SizedBox(
            height: screenSize.getHeightPerSize(1),
          ),
        ],
      ),
    );
  }

  // 내 자산 부분 텍스트 위젯
  Widget _propertyTextWidget(ScreenSize screenSize, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: screenSize.getHeightPerSize(1.6),
            color: colorISEGYEIDOL,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: screenSize.getHeightPerSize(1.6),
            color: colorISEGYEIDOL,
          ),
        ),
      ],
    );
  }

  // 정보 탭 대분류 제목 위젯
  Widget _settingTitle(ScreenSize screenSize, String title) {
    return Padding(
      padding: EdgeInsets.only(left: screenSize.getWidthPerSize(2)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: screenSize.getHeightPerSize(1.8),
          ),
        ),
      ),
    );
  }
}
