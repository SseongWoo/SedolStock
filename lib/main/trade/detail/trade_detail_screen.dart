import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/detail/trade_detail_system.dart';
import 'package:stockpj/main/trade/detail/trade_detail_widget.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/timer.dart';

// 주식 아이템 상세정보 화면
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
        title: Obx(
          () => Opacity(
            opacity: _tradeDetailController.opacity.value,
            child: TradeDetailAppBarTitleWidget(),
          ),
        ),
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
              controller: _tradeDetailController.scrollController,
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
                    DetailVideoListWidget(),
                    SizedBox(
                      height: _screenController.screenSize.value.getHeightPerSize(8),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: _screenController.screenSize.value.getHeightPerSize(1),
              child: TradeDetailButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
