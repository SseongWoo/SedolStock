import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/constants/color_constants.dart';
import 'package:stockpj/utils/screen_size.dart';
import '../../../viewmodel/main/store_view_model.dart';

class StoreScreen extends StatelessWidget {
  final StoreViewModel _viewModel = Get.put(StoreViewModel());
  StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.screenController.updateScreenSize(context);
    });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.getWidthPerSize(2)),
      child: Column(
        children: [
          Container(
            height: screenSize.getHeightPerSize(6),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => _propertyWidget(screenSize, 30, _viewModel.myDataController.myMoney.value),
                ),
                SizedBox(
                  width: screenSize.getWidthPerSize(2),
                ),
                Obx(
                  () => _propertyWidget(screenSize, 20, _viewModel.myDataController.myMoney.value),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 한 줄에 2개의 아이템
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1, // 가로 세로 비율 조정
              ),
              itemCount: 20, // 표시할 아이템 개수
              itemBuilder: (context, index) {
                return _storeItemWidget(index, screenSize);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _propertyWidget(ScreenSize screenSize, double widthSize, int property) {
    return Container(
      height: screenSize.getHeightPerSize(4),
      width: screenSize.getWidthPerSize(widthSize),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.getWidthPerSize(2)),
        child: Center(
          child: AutoSizeText(
            property.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _storeItemWidget(int index, ScreenSize screenSize) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colorMAIN),
      child: Padding(
        padding: EdgeInsets.all(
          screenSize.getHeightPerSize(1),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: screenSize.getWidthSize(),
                color: Colors.green,
                child: Center(child: Text('$index번 아이템')),
              ),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(1),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: screenSize.getWidthSize(),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('구매하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
