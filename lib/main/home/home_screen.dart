import 'package:flutter/material.dart';
import '../../utils/screen_size.dart';
import 'package:get/get.dart';
import 'home_widget.dart';

class HomeScreen extends StatelessWidget {
  final ScreenController _screenController = Get.put(ScreenController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(_screenController.screenSize.value.getWidthPerSize(2)),
          child: Column(
            children: [
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1.5),
              ),
              HomeMyDataWidget(),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1.5),
              ),
              HomeStockDataListWidget(titleText: '관심 종목'),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1.5),
              ),
              HomeStockDataListWidget(titleText: '상승률 top5'),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1.5),
              ),
              HomeStockDataListWidget(titleText: '하강률 top5'),
            ],
          ),
        )),
      ),
    );
  }
}
