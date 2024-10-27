import 'package:flutter/material.dart';
import '../../data/my_data.dart';
import '../../utils/screen_size.dart';
import 'package:get/get.dart';
import 'home_widget.dart';

class HomeScreen extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              HomeLatestVideoListWidget(),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1.5),
              ),
              HomeChannelDataWidget(),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1.5),
              ),
              HomeCafeDataWidget(),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
