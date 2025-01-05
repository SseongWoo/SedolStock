import 'package:flutter/material.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:get/get.dart';
import '../../../utils/format.dart';
import '../../../viewmodel/main/trade/trade_dealing_view_model.dart';

class DealingDialog extends StatelessWidget {
  final TradeDealingViewModel viewModel;
  final ScreenSize screenSize;
  final int price, fee;
  const DealingDialog(
      {super.key,
      required this.viewModel,
      required this.screenSize,
      required this.price,
      required this.fee});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.fromLTRB(screenSize.getWidthPerSize(4), 0, screenSize.getWidthPerSize(4), 0),
        child: Container(
          width: screenSize.getWidthPerSize(92),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: screenSize.getHeightPerSize(2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min, // Dialog 크기를 내용에 맞게 조절
              children: [
                Text(
                  '${viewModel.saleTitle()} 주문 확인',
                  style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(2), fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenSize.getHeightPerSize(2)),
                _dealingTableWidget(
                    '종목명', viewModel.youtubeDataController.channelMapData[viewModel.channelUID]!),
                _dealingTableWidget('종목유형', viewModel.typeTitle()),
                _dealingTableWidget('거래유형', viewModel.saleTitle()),
                _dealingTableWidget(
                    '${viewModel.saleTitle()}수량', '${viewModel.calculatorInt.value}주'),
                _dealingTableWidget('${viewModel.saleTitle()}단가', '${formatToCurrency(price)}원'),
                _dealingTableWidget('총${viewModel.saleTitle()}가격',
                    '${formatToCurrency((price * viewModel.calculatorInt.value))}원'),
                viewModel.buying
                    ? _dealingTableWidget(
                        '${viewModel.saleTitle()}수수료', '${formatToCurrency(fee)}원')
                    : const SizedBox(),
                viewModel.buying
                    ? _dealingTableWidget('총지불금액',
                        '${formatToCurrency((price * viewModel.calculatorInt.value) + fee)}원')
                    : const SizedBox(),
                SizedBox(height: screenSize.getHeightPerSize(2)),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: screenSize.getHeightPerSize(6),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20), // 왼쪽 아래만 둥글게
                                  bottomRight: Radius.circular(0), // 나머지 부분은 둥글지 않게
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                ),
                              ),
                              backgroundColor: Colors.grey),
                          onPressed: () {
                            Get.back(); // 다이얼로그 닫기
                          },
                          child: Text(
                            '취소',
                            style: TextStyle(
                                color: Colors.black, fontSize: screenSize.getHeightPerSize(2)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: screenSize.getHeightPerSize(6),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0), // 왼쪽 아래만 둥글게
                                  bottomRight: Radius.circular(20), // 나머지 부분은 둥글지 않게
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                ),
                              ),
                              backgroundColor: viewModel.buying ? Colors.red : Colors.blue),
                          onPressed: () {
                            Get.back();
                            viewModel.onPressedSaleButton(price);
                          },
                          child: Text(
                            viewModel.saleTitle(),
                            style: TextStyle(
                                color: Colors.white, fontSize: screenSize.getHeightPerSize(2)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 매매내역 다이얼로그속 표 위젯
  Widget _dealingTableWidget(String title, String content) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(screenSize.getWidthPerSize(2), 0, screenSize.getWidthPerSize(2), 0),
      child: SizedBox(
        //height: _screenSize.getHeightPerSize(6),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: screenSize.getHeightPerSize(4),
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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ' $title',
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(2),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ' $content',
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
