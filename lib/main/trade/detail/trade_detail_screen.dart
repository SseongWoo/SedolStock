import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:stockpj/main/trade/detail/trade_detail_system.dart';
import 'package:stockpj/main/trade/detail/trade_detail_widget.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/timer.dart';

class TradeDetailScreen extends StatefulWidget {
  const TradeDetailScreen({super.key});

  @override
  State<TradeDetailScreen> createState() => _TradeDetailScreenState();
}

class _TradeDetailScreenState extends State<TradeDetailScreen> {
  final ScreenController _screenController = Get.find<ScreenController>();
  final TradeDetailController _tradeDetailController = Get.put(TradeDetailController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenController.updateScreenSize(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(channelMapData[_tradeDetailController.channelUID]!),
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
                    const TradeDatailChartWidget(),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    TradeDetailMyStock(),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(1),
                    ),
                    DetailVideoListWidget(),
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
