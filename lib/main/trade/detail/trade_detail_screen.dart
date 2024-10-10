import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/detail/trade_detail_widget.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/timer.dart';

class TradeDetailScreen extends StatefulWidget {
  const TradeDetailScreen({super.key});

  @override
  State<TradeDetailScreen> createState() => _TradeDetailScreenState();
}

class _TradeDetailScreenState extends State<TradeDetailScreen> {
  final ScreenController _screenController = Get.put(ScreenController());
  final TimerController _timerController = Get.put(TimerController());
  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('종목 이름'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: _screenController.screenSize.value.getWidthPerSize(2)),
            child: TimerWidget(),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: _screenController.screenSize.value.getWidthPerSize(2),
                    right: _screenController.screenSize.value.getWidthPerSize(2)),
                child: Column(
                  children: [
                    TradeDatailChartWidget(),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    TradeDetailMyStock(),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    TradeDetailVideoListWidget(),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(7),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: TradeDetailButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
