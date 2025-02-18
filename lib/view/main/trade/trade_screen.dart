import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/view/main/trade/trade_widget.dart';
import '../../../constants/color_constants.dart';
import '../../../model/data/data_class.dart';
import '../../../viewmodel/main/trade/trade_view_model.dart';

// 거래 화면
class TradeScreen extends StatelessWidget {
  final TradeViewModel _viewModel = Get.put(TradeViewModel());
  TradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.screenController.updateScreenSize(context);
    });
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: screenSize.getWidthSize(),
            height: screenSize.getHeightPerSize(0.5),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Obx(
                  () => AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: _viewModel.loadingBarWidth(), // 진행률 계산
                    height: screenSize.getHeightPerSize(0.5),
                    decoration: BoxDecoration(
                      color: _viewModel.loadingBarColor(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: screenSize.getWidthPerSize(1),
                    top: screenSize.getHeightPerSize(0.1),
                    bottom: screenSize.getHeightPerSize(0.1),
                  ),
                  child: Wrap(
                    spacing: screenSize.getWidthPerSize(1),
                    runSpacing: 4.0,
                    children: _viewModel.dropdownItemList.map((filter) {
                      return ChoiceChip(
                        label: Text(filter),
                        selected: _viewModel.selectItemType == filter,
                        showCheckmark: false,
                        onSelected: (value) => _viewModel.selectItemTypeFilter(filter),
                        selectedColor: colorSUB,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: screenSize.getHeightPerSize(1.6),
                          color: _viewModel.selectItemType.value == filter
                              ? Colors.white
                              : Colors.black,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // 모서리를 각지게 설정
                          side: BorderSide(
                            color: colorSUB,
                            width: screenSize.getWidthPerSize(0.3),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: screenSize.getWidthPerSize(2),
                  ),
                  child: Tooltip(
                    message: '서브 채널의 가격 데이터는 등락폭이 작은\n로우리스크 로우리턴 아이템입니다.',
                    triggerMode: TooltipTriggerMode.tap,
                    child: Icon(
                      Icons.info_outline,
                      size: screenSize.getHeightPerSize(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TradeItemTitleWidget(
            screenSize: screenSize,
            icon: (itemType) => _viewModel.sortIcon(itemType), // 아이콘 반환
            onPressed: (itemType) => _viewModel.onPresedSortButton(itemType), // 정렬 동작
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: _viewModel.itemPriceDataList.length, // 아이템 개수 설정
                itemBuilder: (context, index) {
                  return Obx(
                    () {
                      final item = _viewModel.itemPriceDataList[index];
                      final itemUID = item.uid;
                      YoutubeChannelDataClass youtubeData =
                          _viewModel.youtubeDataController.youtubeChannelData[itemUID]!;
                      bool event =
                          _viewModel.publicDataController.eventChannelList[itemUID] != null;

                      return _listItemWidget(
                        screenSize,
                        () => _viewModel.goTradeItem(item.uid),
                        _viewModel.setPriceTitle(item.uid),
                        youtubeData.title,
                        youtubeData.thumbnail,
                        index,
                        item,
                        event,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 리스트뷰 아이템 위젯
  Widget _listItemWidget(ScreenSize screenSize, Function onTapItem, String priceTitle, String title,
      String thumbnail, int index, ItemPriceDataClass itemPriceData, bool event) {
    return Container(
      height: screenSize.getHeightPerSize(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xffA6A6A6),
            width: 0.5,
          ),
          bottom: BorderSide(
            color: Color(0xffA6A6A6),
            width: 0.5,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTapItem(),
          child: Row(
            children: [
              SizedBox(
                width: screenSize.getHeightPerSize(1),
              ),
              SizedBox(
                width: screenSize.getHeightPerSize(6),
                height: screenSize.getHeightPerSize(6),
                child: ClipOval(
                  child: Image.network(
                    thumbnail,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Image.asset('assets/image/image_error.png'),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: screenSize.getHeightPerSize(1),
              ),
              SizedBox(
                width: screenSize.getWidthPerSize(32),
                child: Padding(
                  padding: EdgeInsets.only(right: screenSize.getWidthPerSize(2)),
                  child: Text(
                    '$title${event ? ' 🔥' : ''}',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: screenSize.getHeightPerSize(1.6),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  priceTitle,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: screenSize.getHeightPerSize(1.8),
                  ),
                ),
              ),
              SizedBox(
                width: screenSize.getHeightPerSize(3),
              ),
              SizedBox(
                width: screenSize.getWidthPerSize(24),
                child: differenceTextWidget(screenSize, itemPriceData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
