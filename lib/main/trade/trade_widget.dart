import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/trade_system.dart';
import '../../utils/screen_size.dart';

class TradeItemWidget extends StatelessWidget {
  final ScreenController _screenController = Get.put(ScreenController());
  final TradeController _tradeController = Get.put(TradeController());
  TradeItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Container(
      height: _screenController.screenSize.value.getHeightPerSize(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _tradeController.goTradeItem();
          },
          child: Row(
            children: [
              SizedBox(
                width: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              Container(
                width: _screenController.screenSize.value.getHeightPerSize(6),
                height: _screenController.screenSize.value.getHeightPerSize(6),
                color: Colors.green,
              ),
              SizedBox(
                width: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              Text(
                '종목 이름',
                style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('가격'), Text('변동률')],
              ),
              SizedBox(
                width: _screenController.screenSize.value.getHeightPerSize(1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
