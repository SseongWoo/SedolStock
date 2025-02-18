import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/level.dart';
import '../../../utils/screen_size.dart';
import '../../../viewmodel/main/home_view_model.dart';
import 'home_widget.dart';

// 홈 화면
class HomeScreen extends StatelessWidget {
  final HomeViewModel _viewModel = Get.put(HomeViewModel());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenSize.getWidthPerSize(2)),
          child: Column(
            children: [
              kDebugMode
                  ? ElevatedButton(
                      onPressed: () {
                        _viewModel.publicDataController.getServerData();
                      },
                      child: Text('테스트 버튼'))
                  : SizedBox.shrink(),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              UserInformationWidget(
                viewModel: _viewModel,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              NoticeWidget(
                viewModel: _viewModel,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              EventWidget(
                viewModel: _viewModel,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              NewVideoListWidget(
                viewModel: _viewModel,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              ChannelListWidget(
                viewModel: _viewModel,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
              CafeWidget(
                viewModel: _viewModel,
              ),
              SizedBox(
                height: screenSize.getHeightPerSize(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
