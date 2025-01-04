import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/view/main/property/property_history_widget.dart';
import '../../../utils/format.dart';
import '../../../viewmodel/main/property/property_history_view_model.dart';

// 거래 내역 화면
class PropertyHistoryScreen extends StatelessWidget {
  final PropertyHistoryViewModel _viewModel = Get.put(PropertyHistoryViewModel());
  PropertyHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: screenSize.getHeightPerSize(4),
              width: screenSize.getWidthPerSize(22),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.1,
                    blurRadius: 0.1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: _titleTableText(screenSize, '총 손익금액'),
            ),
            Expanded(
              child: Container(
                height: screenSize.getHeightPerSize(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.1,
                        blurRadius: 0.1,
                        offset: Offset(0, 0)),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: screenSize.getWidthPerSize(1)),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      formatToCurrency(_viewModel.myDataController.totalMoneyHistory.value),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: screenSize.getHeightPerSize(2),
                        color:
                            profitAndLossColor(_viewModel.myDataController.totalMoneyHistory.value),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _titleTableWidget(
                  screenSize, formatToCurrency(_viewModel.myDataController.totalSellHistory.value)),
            ),
            Expanded(
              flex: 1,
              child: _titleTableWidget(
                  screenSize, formatToCurrency(_viewModel.myDataController.totalBuyHistory.value)),
            ),
          ],
        ),
        Container(
          height: screenSize.getHeightPerSize(3),
          width: screenSize.getWidthSize(),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.1),
              bottom: BorderSide(color: Colors.grey, width: 0.1),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              right: screenSize.getWidthPerSize(2),
              left: screenSize.getWidthPerSize(2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Tooltip(
                  message: '거래 내역은 최대 100건까지만 표시됩니다.',
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(
                    Icons.info_outline,
                    size: screenSize.getHeightPerSize(2),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.tune,
                  size: screenSize.getHeightPerSize(2),
                ),
                GestureDetector(
                  onTap: () => _viewModel.createBottomSheet(),
                  child: Text(
                    '필터 설정',
                    style: TextStyle(fontSize: screenSize.getHeightPerSize(1.6)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: PropertyHistoryDataTableWidget(
            viewModel: _viewModel,
          ),
        ),
      ],
    );
  }

  Widget _titleTableWidget(ScreenSize screenSize, String value) {
    return Row(
      children: [
        Container(
          height: screenSize.getHeightPerSize(4),
          width: screenSize.getWidthPerSize(22),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.1,
                blurRadius: 0.1,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: _titleTableText(screenSize, '총 판매금액'),
        ),
        Expanded(
          child: Container(
            height: screenSize.getHeightPerSize(4),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.1,
                  blurRadius: 0.1,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                right: screenSize.getWidthPerSize(1),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: screenSize.getHeightPerSize(2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleTableText(ScreenSize screenSize, String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: screenSize.getHeightPerSize(2),
        ),
      ),
    );
  }
}
