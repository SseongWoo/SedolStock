import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/timer.dart';
import '../../../utils/format.dart';
import '../../../utils/screen_size.dart';
import '../../../viewmodel/main/trade/trade_dealing_view_model.dart';

// 주식 매매 화면
class TradeDealingScreen extends StatelessWidget {
  final TradeDealingViewModel _viewModel = Get.put(TradeDealingViewModel());
  TradeDealingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: screenSize.getWidthPerSize(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: IntrinsicWidth(
                  child: Text(
                    '${_viewModel.youtubeDataController.youtubeChannelData[_viewModel.channelUID]?.title ?? '타이틀'} ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  '(${_viewModel.setPlus()}${_viewModel.itemPriceData.value.ratio.toStringAsFixed(2)}%)',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: profitAndLossColor(_viewModel.itemPriceData.value.ratio)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenSize.getWidthPerSize(2)),
            child: TimerWidget(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
          child: Column(
            children: [
              Container(
                height: screenSize.getHeightPerSize(5),
                width: screenSize.getWidthSize(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.1,
                      blurRadius: 0.1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: screenSize.getHeightPerSize(1)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(
                      () => Text.rich(
                        TextSpan(
                          text: '거래 가능 자산: ', // 기본 텍스트
                          style: TextStyle(
                              fontSize: screenSize.getHeightPerSize(2.2),
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text:
                                  '${formatToCurrency(_viewModel.myDataController.myMoney.value)} P',
                              style: TextStyle(
                                color: _viewModel.buying ? const Color(0xff47C72C) : Colors.grey,
                              ),
                            ),
                            const TextSpan(
                              text: ' / ', // 일반 텍스트
                            ),
                            TextSpan(
                              text: '${_viewModel.ownStock.value.stockCount} 주',
                              style: TextStyle(
                                color: !_viewModel.buying ? const Color(0xff47C72C) : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.1,
                      blurRadius: 0.1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_viewModel.saleTitle()} 가격',
                        style: TextStyle(
                          fontSize: screenSize.getHeightPerSize(2.5),
                        ),
                      ),
                      Obx(
                        () => ListTile(
                          title: Text(
                            '${formatToCurrency(_viewModel.calculatorSum.value)}원',
                            style: TextStyle(
                              fontSize: screenSize.getHeightPerSize(2),
                            ),
                          ),
                          subtitle: Text(
                            '현재 가격 : ${formatToCurrency(_viewModel.itemPriceData.value.price)}원 수수료 : ${formatToCurrency((_viewModel.itemPriceData.value.price * _viewModel.feeRate.value).round())}원',
                            style: TextStyle(
                              fontSize: screenSize.getHeightPerSize(1.4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.1,
                        blurRadius: 0.1,
                        offset: Offset(0, 0)),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenSize.getHeightPerSize(1),
                      screenSize.getHeightPerSize(1), 0, screenSize.getHeightPerSize(1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '주식 ${_viewModel.saleTitle()} 수량',
                        style: TextStyle(
                          fontSize: screenSize.getHeightPerSize(2.5),
                        ),
                      ),
                      ListTile(
                        title: Obx(
                          () => Text(_viewModel.calculatorDisplay.value),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _viewModel.onTapMinus();
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            IconButton(
                              onPressed: () {
                                _viewModel.onTapPlus();
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.1,
                        blurRadius: 0.1,
                        offset: Offset(0, 0)),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _halfMaxButton(screenSize, _viewModel.onTapHalf, '절반'),
                          ),
                          SizedBox(
                            width: screenSize.getWidthPerSize(4),
                          ),
                          Expanded(
                            child: _halfMaxButton(screenSize, _viewModel.onTapMax, '최대'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.getHeightPerSize(1),
                      ),
                      _calculatorNumGroupWidget(
                        screenSize,
                        7,
                        8,
                        9,
                        (index) => _viewModel.onTapNumButton(index),
                      ),
                      SizedBox(
                        height: screenSize.getHeightPerSize(1),
                      ),
                      _calculatorNumGroupWidget(
                        screenSize,
                        4,
                        5,
                        6,
                        (index) => _viewModel.onTapNumButton(index),
                      ),
                      SizedBox(
                        height: screenSize.getHeightPerSize(1),
                      ),
                      _calculatorNumGroupWidget(
                        screenSize,
                        1,
                        2,
                        3,
                        (index) => _viewModel.onTapNumButton(index),
                      ),
                      SizedBox(
                        height: screenSize.getHeightPerSize(1),
                      ),
                      _calculatorNumGroupWidget(
                        screenSize,
                        -2,
                        0,
                        -1,
                        (index) => _viewModel.onTapNumButton(index),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              Row(
                children: [
                  SizedBox(
                    height: screenSize.getHeightPerSize(6),
                    width: screenSize.getWidthPerSize(30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFFC300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _viewModel.onPressedAllDealingButton(),
                      child: Text(
                        '전량 ${_viewModel.saleTitle()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.getHeightPerSize(2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.getWidthPerSize(2),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: screenSize.getHeightPerSize(6),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _viewModel.buttonColor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => _viewModel.onPressedDealingButton(),
                        child: Text(
                          '${_viewModel.saleTitle()} 하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.getHeightPerSize(2),
                          ),
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
    );
  }

  Widget _halfMaxButton(ScreenSize screenSize, Function onPressed, String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: TextStyle(fontSize: screenSize.getHeightPerSize(2), color: Colors.black),
      ),
    );
  }

  Widget _calculatorNumGroupWidget(
      ScreenSize screenSize, int first, int second, int third, Function(int index) onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _calculatorNumButton(
          screenSize,
          first,
          () => onPressed(first), // 콜백 함수 전달
        ),
        SizedBox(
          width: screenSize.getWidthPerSize(4),
        ),
        _calculatorNumButton(
          screenSize,
          second,
          () => onPressed(second), // 콜백 함수 전달
        ),
        SizedBox(
          width: screenSize.getWidthPerSize(4),
        ),
        _calculatorNumButton(
          screenSize,
          third,
          () => onPressed(third), // 콜백 함수 전달
        ),
      ],
    );
  }

  Widget _calculatorNumButton(ScreenSize screenSize, int num, VoidCallback onPressed) // 콜백 타입 변경)
  {
    return SizedBox(
      height: screenSize.getHeightPerSize(8),
      width: screenSize.getWidthPerSize(26),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide.none,
          ),
        ),
        onPressed: onPressed, // 그대로 전달
        child: num == -1
            ? const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )
            : Text(
                num >= 0 ? num.toString() : 'AC',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenSize.getHeightPerSize(2),
                ),
              ),
      ),
    );
  }
}
