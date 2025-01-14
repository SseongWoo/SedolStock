import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/color.dart';
import '../../../constants/color_constants.dart';
import '../../../viewmodel/main/property/property_view_model.dart';

// 지갑 화면
class PropertyScreen extends StatelessWidget {
  final PropertyViewModel _viewModel = Get.put(PropertyViewModel());
  PropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 탭의 개수
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            TabBar(
              labelColor: colorMAIN,
              unselectedLabelColor: colorSUB,
              dividerColor: Colors.white,
              indicator: const BoxDecoration(
                color: colorSUB,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: _tapTextWidget('주식 잔고'),
                ),
                Tab(child: _tapTextWidget('거래 내역')),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: _viewModel.pages,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tapTextWidget(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
