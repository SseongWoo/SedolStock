import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/view/main/property/property_stocklist_widget.dart';
import '../../../constants/color_constants.dart';
import '../../../utils/format.dart';
import '../../../utils/screen_size.dart';
import '../../../viewmodel/main/property/property_stocklist_view_model.dart';

// 보유 주식 리스트 화면
class PropertyStocklistScreen extends StatelessWidget {
  final PropertyStocklistViewModel _viewModel = Get.put(PropertyStocklistViewModel());
  PropertyStocklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: screenSize.getHeightPerSize(1),
            width: screenSize.getWidthSize(),
            color: colorSUB,
          ),
          Column(
            children: [
              Obx(
                () => SizedBox(
                  height: screenSize.getHeightPerSize(10),
                  child: Row(
                    children: [
                      _buildAssetColumn(
                          '가용 자산',
                          '${formatToCurrency(_viewModel.myDataController.myMoney.value)} P',
                          screenSize),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: screenSize.getWidthPerSize(0.3),
                      ),
                      _buildAssetColumn(
                          '총 자산',
                          '${formatToCurrency(_viewModel.myDataController.myTotalMoney.value)} P',
                          screenSize),
                    ],
                  ),
                ),
              ),
              Container(
                height: screenSize.getHeightPerSize(0.1),
                width: screenSize.getWidthSize(),
                color: colorSUB,
              ),
            ],
          ),
          GestureDetector(
            onTap: _viewModel.toggleChartExpansion,
            child: Obx(
              () => Icon(
                _viewModel.isExpandedChart.value ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                size: screenSize.getHeightPerSize(5),
                color: colorSUB,
              ),
            ),
          ),
          Obx(
            () => Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: SizedBox(width: screenSize.getWidthSize()),
                secondChild: SizedBox(
                  height: screenSize.getHeightPerSize(38),
                  child: PropertyStockPieChartWidget(
                    viewModel: _viewModel,
                  ),
                ),
                crossFadeState: _viewModel.isExpandedChart.value
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ),
          ),
          Obx(
            () {
              final stockDataList = _viewModel.myDataController.stockListItem.values.toList();
              if (stockDataList.isEmpty) {
                return Center(
                    child: Text(
                  '보유중인 주식이 없습니다.',
                  style: TextStyle(fontSize: screenSize.getHeightPerSize(2)),
                ));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stockDataList.length,
                itemBuilder: (context, index) {
                  final stockData = stockDataList[index];
                  return PropertyStockListItemWidget(
                    viewModel: _viewModel,
                    stockData: stockData,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAssetColumn(String title, String value, ScreenSize screenSize) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: screenSize.getHeightPerSize(2.5)),
          ),
          SizedBox(height: screenSize.getHeightPerSize(0.5)),
          Text(
            value,
            style: TextStyle(
              fontSize: screenSize.getHeightPerSize(2.5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
